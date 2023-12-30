import { Controller, Get } from '@nestjs/common';
import { TrainersService } from './trainers.service';

@Controller('trainers')
export class TrainersController {
  constructor(private readonly trainersService: TrainersService) {}

  @Get()
  async findAll() {
    const trainers = await this.trainersService.findAll();
    return trainers;
  }
}
