import { Controller, Get, Param, NotFoundException } from '@nestjs/common';
import { RolesService } from './roles.service';

@Controller('roles')
export class RolesController {
  constructor(private readonly rolesService: RolesService) {}

  @Get()
  async findAll() {
    const roles = await this.rolesService.findAll();
    return roles;
  }

  @Get(':roleName')
  async findOne(@Param('roleName') roleName: string) {
    const role = await this.rolesService.findOne(roleName);

    if (!role)
      throw new NotFoundException(
        `Role with name: ${roleName} does not exist.`,
      );

    return role;
  }
}
