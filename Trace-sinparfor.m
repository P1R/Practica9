function Trace()
    VideoIn = input('Ingresa ruta y nombre de video:','s');
    VideoOut = ['Final-',VideoIn];
    ruta=what;
    mkdir Images;
    system(['ffmpeg -i ',VideoIn,' ',ruta.path,'\Images\img%3d.jpg']);
    cd Images;
    a=dir;
    %mkdir FINAL;
    fin=size(a);
    for i=3:fin(1)
        ['procesando... ',a(i).name]
        x=imread(a(i).name);
        y=imread(a(i).name);
        x=rgb2gray(x);
        X = (x >= 128).* 255;
        %seccion apertura y cierre
        se = strel('ball',5,5);
        X = imclose(imopen( X,se),se);
        %seccion detectar formas
        imageR=bwlabel(X,8);
        TopeOBJ = max(max(imageR));
        %detectar centros de visionmatlab
        %s=imfeature(imageR,'Centroid');
        s= regionprops(imageR,'Centroid');
        %%seccion de marcado
        imshow(y);
        hold on
        for j=1:TopeOBJ
            objeto=fix(s(j).Centroid);
             plot(objeto(1),objeto(2),'r+')
        end
        hold off
        saveas(gcf,a(i).name);
        close Figure 1;
        %finaliza marcado por imagen
        %imwrite(X,['FINAL\',a(i).name],'jpg');
    end
    %recreamos el video
    system(['ffmpeg -f image2 -i img%3d.jpg ','..\',VideoOut]);
    cd ..;