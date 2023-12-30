import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { UserrolesService } from './userroles.service';
import { CreateUserroleDto } from './dto/create-userrole.dto';

@Controller('userroles')
export class UserrolesController {
  constructor(private readonly userrolesService: UserrolesService) {}

  @Post()
  async create(@Body() createUserroleDto: CreateUserroleDto) {
    const userRole = await this.userrolesService.create(createUserroleDto);
    return userRole;
  }

  @Get()
  async findAll() {
    const userRoles = await this.userrolesService.findAll();
    return userRoles;
  }

  @Get('roles/:id')
  async findRolesByUser(@Param('id') id: string) {
    const userRoles = await this.userrolesService.findRolesByUser(id);
    return userRoles;
  }

  @Get('users/:roleName')
  async findUsersByRole(@Param('roleName') roleName: string) {
    const userRoles = await this.userrolesService.findUsersByRole(roleName);
    return userRoles;
  }

  @Delete(':id/:roleName')
  async remove(@Param('id') id: string, @Param('roleName') roleName: string) {
    const userRole = await this.userrolesService.remove(id, roleName);
    return userRole;
  }
}
