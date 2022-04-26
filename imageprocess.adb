with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body imageprocess is

-- a subprogram which performs an image inversion
function imageINV(img: in imge) return imge is 
    invimg : imge;
begin
    invimg.dx := img.dx;
    invimg.dy := img.dy;
    invimg.pixVal := img.pixVal;
    for i in 1..img.dx loop
        for j in 1..img.dy loop
            invimg.pixel(i,j) := abs(255-img.pixel(i,j));
        end loop;
    end loop;

    return invimg;
end;

-- a subprogram which performs a logarithmic transformation 
-- (mapping a narrow range of low intensity pixels into a wider range of output levels)
function imageLOG(img: in imge) return imge is
    logimg : imge;
    pixel : float;
begin
    logimg.dx := img.dx;
    logimg.dy := img.dy;
    logimg.pixVal := img.pixVal;
    for i in 1..img.dx loop
        for j in 1..img.dy loop
        pixel := float(img.pixel(i,j))+1.0;
            logimg.pixel(i,j) := integer( log(pixel, 10.0) * 255.0/log(255.0, 10.0) );
        end loop;
    end loop;

    return logimg;
end;

-- a subprogram which performs a contrast stretching
function imageSTRETCH(img: in imge; imin: in integer; imax: in integer) return imge is
    stretchimg : imge;
begin
    stretchimg.dx := img.dx;
    stretchimg.dy := img.dy;
    stretchimg.pixVal := img.pixVal;
    for i in 1..img.dx loop
        for j in 1..img.dy loop
            stretchimg.pixel(i,j) := integer(255.0 * float(img.pixel(i,j) - imin) / (float(imax - imin)));
            if stretchimg.pixel(i,j) < 0 then
                stretchimg.pixel(i,j) := 255;
            end if;
        end loop;
    end loop;

    return stretchimg;
end;

-- a subprogram that calculates a histogram of an image I 
-- returns the histogram as a 1-dimensional array
function makeHIST(img: in imge; hist: out histogram) return histogram is
    index : integer;
begin
    hist.count := (others => 0);
    for i in 1..img.dx loop
        for j in 1..img.dy loop
            index := img.pixel(i,j) + 1;
            hist.count(index) := hist.count(index) + 1;
        end loop;
    end loop;

    return hist;
end;

-- a subprogram which performs the histogram equalization of an image I
-- returns the enhanced image
function histEQUAL(img: in imge; hist: in histogram) return imge is
    equalimg : imge;
    cumsum : array (1..256) of float;
begin
    -- calculate the cumulative sum of the histogram values
    for i in 1..256 loop
        if i = 1 then
            cumsum(i) := float(hist.count(i));
        else
            cumsum(i) := cumsum(i-1) + float(hist.count(i));
        end if;
    end loop;

    -- normalize the cumulative sum by dividing by the total number of pixels
    -- then multiply by the maximum grayscale value (i.e., 255)
    for i in 1..256 loop
        cumsum(i) := 255.0 * cumsum(i) / (float(img.dx) * float(img.dy));
    end loop;

    -- map the original values to the results of the array above to calculate histogram equalization
    for i in 1..img.dx loop
        for j in 1..img.dy loop
            equalimg.pixel(i,j) := integer(cumsum(img.pixel(i,j)));
        end loop;
    end loop;

    return equalimg;
end;

end imageprocess;