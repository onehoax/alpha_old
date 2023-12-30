import { PartialType } from '@nestjs/mapped-types';
import { CreateInjuredclientDto } from './create-injuredclient.dto';

export class UpdateInjuredclientDto extends PartialType(CreateInjuredclientDto) {}
