import { Injectable, NotFoundException } from '@nestjs/common';
import { UpdateClientDto } from './dto/update-client.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ClientsService {
  constructor(private prisma: PrismaService) {}

  findAll() {
    return this.prisma.client.findMany({ include: { app_user: true } });
  }

  async update(id: string, updateClientDto: UpdateClientDto) {
    const user = await this.prisma.app_user.findUnique({
      where: { government_id: id },
    });

    if (!user)
      throw new NotFoundException(`User with id ${id} does not exist.`);

    const updatedClient = {
      ...updateClientDto,
      updated_at: new Date(),
    };

    return this.prisma.client.update({
      where: { client_id: user.user_id },
      data: updatedClient,
    });
  }
}
