import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateInjuredclientDto } from './dto/create-injuredclient.dto';
import { UpdateInjuredclientDto } from './dto/update-injuredclient.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class InjuredclientsService {
  constructor(private prisma: PrismaService) {}

  findAll() {
    return this.prisma.client_injured.findMany({ include: { client: true } });
  }

  async update(id: string, updateInjuredclientDto: UpdateInjuredclientDto) {
    const user = await this.prisma.app_user.findUnique({
      where: { government_id: id },
    });

    if (!user)
      throw new NotFoundException(`User with id ${id} does not exist.`);

    const updatedClient = {
      ...updateInjuredclientDto,
      updated_at: new Date(),
    };

    return this.prisma.client_injured.update({
      where: { client_injured_id: user.user_id },
      data: updatedClient,
    });
  }
}
