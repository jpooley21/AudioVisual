columns = 1;
rows = 12;

% Arr = zeros(rows,columns);
% disp(Arr);
% %Delete first column
% Arr(:,1) = [];
% NewCol = rand(12,1);
% %Add new column
% Arr = [Arr NewCol];
% disp(Arr);
% 
% NewCol2 = rand(12,1);
% Arr = [Arr NewCol2];
% disp(Arr);

Arr = zeros(rows,columns);



for i = columns:10
%     Arr(:,columns) = [];
    NewCol = rand(12,columns);
    Arr = [Arr NewCol];
    disp(Arr);
end 
    

