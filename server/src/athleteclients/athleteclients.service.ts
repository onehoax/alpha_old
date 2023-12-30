import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateAthleteclientDto } from './dto/create-athleteclient.dto';
import { UpdateAthleteclientDto } from './dto/update-athleteclient.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class AthleteclientsService {
  constructor(private prisma: PrismaService) {}

  findAll() {
    return this.prisma.client_athlete.findMany({ include: { client: true } });
  }

  async update(id: string, updateAthleteclientDto: UpdateAthleteclientDto) {
    const user = await this.prisma.app_user.findUnique({
      where: { government_id: id },
    });

    if (!user)
      throw new NotFoundException(`User with id ${id} does not exist.`);

    const updatedClient = {
      ...updateAthleteclientDto,
      updated_at: new Date(),
    };

    return this.prisma.client_athlete.update({
      where: { client_athlete_id: user.user_id },
      data: updatedClient,
    });
  }
}
