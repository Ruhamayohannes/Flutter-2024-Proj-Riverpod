import { User } from "src/user/schemas/user.schema";
import { File } from 'multer';
export declare class CreatePostsDto {
    readonly name: string;
    readonly description: string;
    readonly contact: string;
    readonly user: User;
    readonly image: File;
}
