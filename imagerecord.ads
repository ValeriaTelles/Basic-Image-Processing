package imagerecord is

    type pixelMatrix is array(1..500, 1..500) of integer;
    type pixelHist is array (1..256) of integer;

    type imge is
        record
            pixel : pixelMatrix;
            dx : integer; 
            dy : integer; 
            pixVal : integer;
        end record;

    type histogram is 
        record
            count : pixelHist;
        end record;

end imagerecord;