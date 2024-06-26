import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { AuthModule } from 'src/auth/auth.module';
import { MongooseModule } from '@nestjs/mongoose';
import { UserSchema } from './schemas/user.schema';

@Module({
  imports: [
    AuthModule,
    MongooseModule.forFeature([{name:'user', schema:UserSchema}])
  ],
  providers: [UserService],
  controllers: [UserController]
})
export class UserModule {}
