import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { AthleteclientsService } from './athleteclients.service';
import { CreateAthleteclientDto } from './dto/create-athleteclient.dto';
import { UpdateAthleteclientDto } from './dto/update-athleteclient.dto';

@Controller('athleteclients')
export class AthleteclientsController {
  constructor(private readonly athleteclientsService: AthleteclientsService) {}

  @Get()
  async findAll() {
    const athleteClients = await this.athleteclientsService.findAll();
    return athleteClients;
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateAthleteclientDto: UpdateAthleteclientDto,
  ) {
    const athleteclient = await this.athleteclientsService.update(
      id,
      updateAthleteclientDto,
    );
    return athleteclient;
  }
}
