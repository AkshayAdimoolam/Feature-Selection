function data
 b='.jpg';
 c1='.bmp';
fid = fopen('database.txt', 'w+');
for i=1:82
    a=num2str(i);
   filename=strcat(a,b);
    fprintf(fid,'%s\r',filename);
end
fclose(fid);