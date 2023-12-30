import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { InjuredclientsService } from './injuredclients.service';
import { CreateInjuredclientDto } from './dto/create-injuredclient.dto';
import { UpdateInjuredclientDto } from './dto/update-injuredclient.dto';

@Controller('injuredclients')
export class InjuredclientsController {
  constructor(private readonly injuredclientsService: InjuredclientsService) {}

  @Get()
  async findAll() {
    const injuredClients = await this.injuredclientsService.findAll();
    return injuredClients;
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateInjuredclientDto: UpdateInjuredclientDto,
  ) {
    const injuredClient = await this.injuredclientsService.update(
      id,
      updateInjuredclientDto,
    );
    return injuredClient;
  }
}
