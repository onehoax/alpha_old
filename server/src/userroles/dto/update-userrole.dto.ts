import { PartialType } from '@nestjs/mapped-types';
import { CreateUserroleDto } from './create-userrole.dto';

export class UpdateUserroleDto extends PartialType(CreateUserroleDto) {}
