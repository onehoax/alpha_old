import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  create(createUserDto: CreateUserDto) {
    const newUser = {
      ...createUserDto,
      dob: new Date(createUserDto.dob),
      updated_at: new Date(),
    };

    return this.prisma.app_user.create({ data: newUser });
  }

  findAll() {
    return this.prisma.app_user.findMany();
  }

  findOne(id: string) {
    return this.prisma.app_user.findUnique({
      where: { government_id: id },
    });
  }

  update(id: string, updateUserDto: UpdateUserDto) {
    const updatedUser = {
      ...updateUserDto,
      updated_at: new Date(),
    };

    if (updateUserDto.dob) updatedUser.dob = new Date(updateUserDto.dob);

    return this.prisma.app_user.update({
      where: { government_id: id },
      data: updatedUser,
    });
  }

  remove(id: string) {
    return this.prisma.app_user.delete({ where: { government_id: id } });
  }
}
