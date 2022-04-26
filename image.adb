with ada.Text_IO; use Ada.Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with ada.directories; use ada.directories;
with imagepgm; use imagepgm;
with imageprocess; use imageprocess;
with imagerecord; use imagerecord;

procedure image is
   filename : unbounded_string;
   strChoice : unbounded_string;
   numChoice : integer;
   numMin, numMax : integer;
   imin, imax : unbounded_string;
   imgO, imgN, imgI, imgL, imgH, imgS : imge;
   histO, histN : histogram;

   procedure getFilename is
   begin
   loop
      put_line("Enter input image filename: "); -- prompt user for input file
      get_line(filename);
      if exists(to_string(filename)) then
         exit; -- exit the loop if the file does exist
      else
         put_line(standard_error, "Error - this file does not exist"); -- throw an error if the file does not exist
      end if;
   end loop;
   end getFilename;


   procedure printMenu is
   begin
   put_line("Image Processing"); 
   put_line("1. Read in PGM image from file"); 
   put_line("2. Apply image inversion"); 
   put_line("3. Apply LOG function"); 
   put_line("4. Apply contrast stretching"); 
   put_line("5. Apply histogram equalization"); 
   put_line("6. Write PGM image to file"); 
   put_line("7. Quit"); 

   loop 
      put_line("Choice?");
      get_line(strChoice);
      numChoice := integer'value(to_string(strChoice));

      -- find out what choice was made
      if numChoice = 1 then
         getFilename; 
         readPGM(imgO,filename); -- read the file
         imgN := imgO; -- new image
      elsif numChoice = 2 then
         imgI := imageINV(imgN); -- inversion
         imgN := imgI;
      elsif numChoice = 3 then
         imgL := imageLOG(imgN); -- log transformation
         imgN := imgL;
      elsif numChoice = 4 then
         put_line("Enter the imin (0-255):"); -- prompt user for minimum intensity
         get_line(imin);
         put_line("Enter the imax (0-255):"); -- prompt user for maximum intensity
         get_line(imax);
         numMin := integer'value(to_string(imin));
         numMax := integer'value(to_string(imax));
         imgS := imageSTRETCH(imgN, numMin, numMax); -- contrast stretching
         imgN := imgS;
      elsif numChoice = 5 then
         histN := makeHIST(imgN, histO); -- create the histogram for an image
         imgH := histEQUAL(imgN, histN); -- histogram equalization
         imgN := imgH;
      elsif numChoice = 6 then
         put_line("Enter output image filename (include .pgm at the end): "); -- prompt user for output file
         get_line(filename);
         writePGM(imgN,filename); -- write to file
      elsif numChoice = 7 then
         put_line("Exiting Program...");
         exit;
      else 
         put_line(standard_error, "Error - Invalid Choice"); 
      end if;
   end loop;
   end printMenu;

   begin
   printMenu;
end image;
