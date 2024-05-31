import { IsEmpty, IsNotEmpty, IsString } from "class-validator";
import { User } from "src/user/schemas/user.schema";
import { File } from 'multer';

export class CreatePostsDto {

    @IsNotEmpty()
    @IsString()
    readonly name: string;

    @IsNotEmpty()
    @IsString()
    readonly description: string;

    @IsNotEmpty() 
    @IsString()
    readonly contact: string;

    @IsEmpty({ message: 'you can not pass user id' })
    readonly user: User;

    readonly image: File;
}
