import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateUserroleDto } from './dto/create-userrole.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UserrolesService {
  readonly TRAINER_ROLE = 'trainer';
  readonly SPRO_ROLE = 'sports_professional';
  readonly PHYSIO_ROLE = 'physio';
  readonly CLIENT_ROLE = 'client';
  readonly INJURED_ROLE = 'injured';
  readonly ATHLETE_ROLE = 'athlete';

  constructor(private prisma: PrismaService) {}

  async create(createUserroleDto: CreateUserroleDto) {
    const userId = createUserroleDto.user_id;
    const roleName = createUserroleDto.role_id;

    const user = await this.prisma.app_user.findUnique({
      where: { government_id: userId },
    });

    if (!user)
      throw new NotFoundException(`User with id: ${userId} does not exist.`);

    const role = await this.prisma.role.findUnique({
      where: { code_name: roleName },
    });

    if (!role)
      throw new NotFoundException(
        `Role with name: ${roleName} does not exist.`,
      );

    const newUserRole = {
      user_id: user.user_id,
      role_id: role.role_id,
      updated_at: new Date(),
    };

    // create the entry in the corresponding table depending on the role
    // this is done before the creation of the user_role so that if there are any
    // conflicts (creating a client_injured entry with a user_id that is not present in client),
    // it will throw a conflict error and not create the user_role
    switch (roleName) {
      case this.TRAINER_ROLE:
        await this.prisma.trainer.create({
          data: { trainer_id: user.user_id, updated_at: new Date() },
        });
        break;
      case this.SPRO_ROLE:
      case this.PHYSIO_ROLE:
        const trainerRole = await this.prisma.role.findUnique({
          where: { code_name: this.TRAINER_ROLE },
        });
        const trainerUserRole = await this.prisma.user_role.findUnique({
          where: {
            user_id_role_id: {
              user_id: user.user_id,
              role_id: trainerRole.role_id,
            },
          },
        });

        if (!trainerUserRole)
          throw new ConflictException(
            `User must be a trainer before they can be a ${roleName}`,
          );
        break;
      case this.CLIENT_ROLE:
        await this.prisma.client.create({
          data: {
            client_id: user.user_id,
            is_active: true,
            age: new Date().getFullYear() - new Date(user.dob).getFullYear(),
            updated_at: new Date(),
          },
        });
        break;
      case this.INJURED_ROLE:
        await this.prisma.client_injured.create({
          data: {
            client_injured_id: user.user_id,
            updated_at: new Date(),
          },
        });
        break;
      case this.ATHLETE_ROLE:
        await this.prisma.client_athlete.create({
          data: { client_athlete_id: user.user_id, updated_at: new Date() },
        });
        break;
    }

    return this.prisma.user_role.create({ data: newUserRole });
  }

  findAll() {
    return this.prisma.user_role.findMany({
      include: { app_user: true, role: true },
    });
  }

  async findRolesByUser(id: string) {
    const user = await this.prisma.app_user.findUnique({
      where: { government_id: id },
    });

    if (!user)
      throw new NotFoundException(`User with id: ${id} does not exist.`);

    return this.prisma.user_role.findMany({
      where: { user_id: user.user_id },
      include: { app_user: true, role: true },
    });
  }

  async findUsersByRole(roleName: string) {
    const role = await this.prisma.role.findUnique({
      where: { code_name: roleName },
    });

    if (!role)
      throw new NotFoundException(
        `Role with name: ${roleName} does not exist.`,
      );

    return this.prisma.user_role.findMany({
      where: {
        role_id: role.role_id,
      },
      include: {
        app_user: true,
        role: true,
      },
    });
  }

  async remove(id: string, roleName: string) {
    const user = await this.prisma.app_user.findUnique({
      where: { government_id: id },
    });

    if (!user)
      throw new NotFoundException(`User with id: ${id} does not exist.`);

    const role = await this.prisma.role.findUnique({
      where: { code_name: roleName },
    });

    if (!role)
      throw new NotFoundException(
        `Role with name: ${roleName} does not exist.`,
      );

    // delete the entry in the corresponding table depending on the role
    // this is done before the deletion of the user_role so that if there are any
    // conflicts (deleting a client that doesn't exist),
    // it will throw a not found error and not delete the user_role
    switch (roleName) {
      case this.TRAINER_ROLE:
        // a user needs to be a trainer to have roles 'sports_professional' and 'physio'; remove these role(s) for the user as well if they exist
        const sProRole = await this.prisma.role.findUnique({
          where: { code_name: this.SPRO_ROLE },
        });
        const sProUserRole = await this.prisma.user_role.findUnique({
          where: {
            user_id_role_id: {
              user_id: user.user_id,
              role_id: sProRole.role_id,
            },
          },
        });

        const physioRole = await this.prisma.role.findUnique({
          where: { code_name: this.PHYSIO_ROLE },
        });
        const physioUserRole = await this.prisma.user_role.findUnique({
          where: {
            user_id_role_id: {
              user_id: user.user_id,
              role_id: physioRole.role_id,
            },
          },
        });

        if (sProUserRole)
          await this.prisma.user_role.delete({
            where: {
              user_id_role_id: {
                user_id: user.user_id,
                role_id: sProRole.role_id,
              },
            },
          });

        if (physioUserRole)
          await this.prisma.user_role.delete({
            where: {
              user_id_role_id: {
                user_id: user.user_id,
                role_id: physioRole.role_id,
              },
            },
          });

        await this.prisma.trainer.delete({
          where: { trainer_id: user.user_id },
        });
        break;
      case this.CLIENT_ROLE:
        // a user needs to be a client to have roles 'injured' and 'athlete'; remove these role(s) for the user as well if they exist
        const injuredRole = await this.prisma.role.findUnique({
          where: { code_name: this.INJURED_ROLE },
        });
        const injuredUserRole = await this.prisma.user_role.findUnique({
          where: {
            user_id_role_id: {
              user_id: user.user_id,
              role_id: injuredRole.role_id,
            },
          },
        });

        const athleteRole = await this.prisma.role.findUnique({
          where: { code_name: this.ATHLETE_ROLE },
        });
        const athleteUserRole = await this.prisma.user_role.findUnique({
          where: {
            user_id_role_id: {
              user_id: user.user_id,
              role_id: athleteRole.role_id,
            },
          },
        });

        if (injuredUserRole)
          await this.prisma.user_role.delete({
            where: {
              user_id_role_id: {
                user_id: user.user_id,
                role_id: injuredRole.role_id,
              },
            },
          });

        if (athleteUserRole)
          await this.prisma.user_role.delete({
            where: {
              user_id_role_id: {
                user_id: user.user_id,
                role_id: athleteRole.role_id,
              },
            },
          });

        // FQ constraints will take care of the deletion on the client_injured and client_athlete tables
        await this.prisma.client.delete({ where: { client_id: user.user_id } });

        break;
      case this.INJURED_ROLE:
        await this.prisma.client_injured.delete({
          where: { client_injured_id: user.user_id },
        });
        break;
      case this.ATHLETE_ROLE:
        await this.prisma.client_athlete.delete({
          where: { client_athlete_id: user.user_id },
        });
        break;
    }

    return this.prisma.user_role.delete({
      where: {
        user_id_role_id: { user_id: user.user_id, role_id: role.role_id },
      },
    });
  }
}
