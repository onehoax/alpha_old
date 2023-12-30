import { Body, Controller, Get, Param, Patch } from '@nestjs/common';
import { ClientsService } from './clients.service';
import { UpdateClientDto } from './dto/update-client.dto';

@Controller('clients')
export class ClientsController {
  constructor(private readonly clientsService: ClientsService) {}

  @Get()
  async findAll() {
    const clients = await this.clientsService.findAll();
    return clients;
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updatedClientDto: UpdateClientDto,
  ) {
    const client = await this.clientsService.update(id, updatedClientDto);
    return client;
  }
}
