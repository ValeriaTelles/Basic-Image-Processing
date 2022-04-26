with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with ada.directories; use ada.directories;

package body imagepgm is

-- read the file provided and return a record representing the image
procedure readPGM(img: out imge; fname: in unbounded_string) is
    infp : file_type;
    id : unbounded_string;
begin
    open(infp, in_file, to_string(fname));
    get_line(infp, id);
    -- check to see if the magic identifier is correct (i.e., P2)
    if to_string(id) /= "P2" then
        put_line(standard_error, "Error - you are using the wrong magic identitifier");
    end if;

    get(infp, img.dy);
    get(infp, img.dx);
    get(infp, img.pixVal);

    for i in 1..img.dx loop
        for j in 1..img.dy loop
            get(infp, img.pixel(i,j));
        end loop;
    end loop;
    close(infp);
end;

-- write the image to file as a P2 PGM format after any amount of image transformations
procedure writePGM(img: in imge; fname: in unbounded_string) is
    outfp : file_type;
    ans : character;
begin
    -- if the output filename already exists ask to overwrite
    if exists(to_string(fname)) then
        put_line("File exists - overwrite (Y/N)? ");
        get(ans);
        skip_line;
        if ans = 'Y' then
            create(outfp, out_file, to_string(fname));
        else
            put_line("Exiting - image not saved");
            return;
        end if;
    else
        -- create the output file
        create(outfp, out_file, to_string(fname));
    end if;

    set_output(outfp);
    put(outfp, "P2"); new_line;
    put(img.dy, width=>4);
    put(img.dx, width=>4); new_line;
    put(img.pixVal, width=>4); new_line;

    for i in 1..img.dx loop
        for j in 1..img.dy loop
            put(img.pixel(i,j), width=>4);
        end loop;
        new_line;
    end loop;

    set_output(standard_output);
    close(outfp);
end;

end imagepgm;