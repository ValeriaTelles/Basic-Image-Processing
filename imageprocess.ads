with imagerecord; use imagerecord;

package imageprocess is

    function imageINV(img: in imge) return imge;
    function imageLOG(img: in imge) return imge;
    function imageSTRETCH(img: in imge; imin: in integer; imax: in integer) return imge;
    function makeHIST(img: in imge; hist: out histogram) return histogram;
    function histEQUAL(img: in imge; hist: in histogram) return imge;

end imageprocess;