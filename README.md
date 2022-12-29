# Basic Image Processing 
An Ada written program that performs basic image processing operations on a grayscale image stored in an ASCII P2 PGM format.

## Image Processing Techniques Available

 - **Image Inversion:** light areas are mapped to dark, and dark areas are mapped to light.
 - **Logarithmic Transformation:** expands the dark pixels in the image while compressing the brighter pixels.
 - **Contrast Stretching (Normalization):** improves the contrast of an image by stretching the intensity values of an image to fill the entire dynamic range.
 - **Histogram Equalization:** improves the contrast of an image by using its histogram. The intensity values of an image are modified such that the histogram is "flattened". Note that this is not the same as contrast stretching.

## How to Use
1. Compile with ```gnatmake -Wall imagepgm.adb imageprocess.adb image.adb```
2. Run with ```./image```
3. A menu will appear where selections can be made to read in a PGM image from file, apply any image processing techniques available, write PGM image to file, and then quit.

### Image Processing Menu
 1. Read in PGM image form file
 2. Apply image inverstion
 3. Apply LOG function
 4. Apply contrast stretching
 5. Apply histogram equalization
 6. Write PGM image to file
 7. Quit
