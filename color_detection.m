%Parameters
H_min = .35;
H_max = .6;
S_min = .0;
S_max = 1;
V_min = .1;
V_max = 1;

%Load image

rgb_img = imread('im1.JPG');

pause();
%Convert from RGB to HSV color map
hsv_img = rgb2hsv(rgb_img);
image(hsv_img);
%pause();
%Apply thresholds to RGB image

A = size(hsv_img);
for y = 1:A(1)
    for x = 1:A(2)
        H = hsv_img(y,x,1);
        S = hsv_img(y,x,2);
        V = hsv_img(y,x,3);
        if (H>H_max)||(H<H_min)||(S>S_max)||(S<S_min)||(V>V_max)||(V<V_min)
            %If hue is not in range
            rgb_img(y,x,1)=0;
            rgb_img(y,x,2)=0;
            rgb_img(y,x,3)=0;
        else
            %hue is in range
            rgb_img(y,x,1)=255;
            rgb_img(y,x,2)=255;
            rgb_img(y,x,3)=255;
        end
    end
end

image(hsv_img);