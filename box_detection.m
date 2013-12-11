%TO-DO:  Normalize distance in convexity measurement

clear;
clf;
rgb_img = imread('im5.JPG');
figure(1);
imshow(rgb_img);
gray_img = rgb2gray(rgb_img);
%Detect Edges
edge_img = edge(gray_img,'canny', [0.3 0.4], 1);
%Link Edges
[edgelist, labelededgeim] = edgelink(edge_img, 10);
[Gx,Gy] = imgradientxy(gray_img);
figure(2);
imshow(labelededgeim);

%Find Average Gradient Convexity
    %Find linked edge central moment
    for i = 1:length(edgelist)
        edge = edgelist{i};
        hold on;
        center = mean(edge);
        %find vector from point on edge to center of edge
        edge_offset = bsxfun(@minus, edge, center);
        sumConvexity = 0;
        
            disp('edge');
        for j = 1:length(edge)
            edge_pt = edge(j,:);
            xj = edge_pt(1);
            %if xj > 480
            %    xj=480;
            %end
            yj = edge_pt(2);
            %if yj > 640
            %    yj = 640;
            %end
            Gxj = Gx(xj,yj);
            Gyj = Gy(xj,yj);
            Gj = [Gyj,Gxj];
            %disp('grad');
            %disp(Gj);
            %disp('edge_offset');
            %disp(edge_offset(j,:));
            convexity = dot(edge_offset(j,:)/norm(edge_offset(j,:)),Gj);
            sumConvexity = sumConvexity + convexity;
        end
        disp('avgconvexity');
        avgConvexity = sumConvexity/length(edge);
        convThresh = 3*10^2;
        if(avgConvexity > convThresh)
            plot(center(:,2),center(:,1),'bO');
            plot(edge(:,2),edge(:,1),'r.');
        end
    end
    %Get gradient image
    %Find gradient convexity (edg(i)-center)dot(G(edg(i)))

%drawedgelist(edgelist, size(gray_img), 1, 'rand', 2); axis off
% Fit line segments to the edgelists
%    tol = 2;         % Line segments are fitted with maximum deviation from
% original edge of 2 pixels.
%seglist = lineseg(edgelist, tol);

% Draw the fitted line segments stored in seglist in figure window 3 with
% a linewidth of 2 and random colours
%drawedgelist(seglist, size(gray_img), 2, 'rand', 3); axis off

%Corner
%corners = corner(gray_img,'QualityLevel',0.1);
%imshow(gray_img);
%hold on
%plot(corners(:,1),corners(:,2),'r*');


%Gradient
%[Gx,Gy] = imgradientxy(gray_img);
%[Gmag, Gdir] = imgradient(Gx,Gy);
%figure, imshow(Gmag, []), title('Gradient magnitude')
%figure, imshow(Gdir, []), title('Gradient direction')
%figure, imshow(Gx, []), title('Directional gradient: X axis')
%figure, imshow(Gy, []), title('Directional gradient: Y axis')