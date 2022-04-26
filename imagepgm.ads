with ada.strings.unbounded; use ada.strings.unbounded;
with imagerecord; use imagerecord;

package imagepgm is
    
    procedure readPGM(img: out imge; fname: in unbounded_string);
    procedure writePGM(img: in imge; fname: in unbounded_string);

end imagepgm;