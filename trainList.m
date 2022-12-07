

% names = ["Adam", "Agne", "Bradley", "Cameron", 
% "Darcey", "Dylan", "Georgiana", "Jack", "James",
% "Jonathon", "Jordan", "Liam", "Max", "Mikhayla",
% "Rob", "Shaun", "Sophie", "Tan", "Teodora", "Tom"];
% 
% % fileName = "trainList";
% 
% for name = names(name) : length(names)
%     fprintf(name);
%     fprintf(names);
%     for i = 1:10
%        writelines("MFCCs\train\" + name + i + ".lab", fileName);
%     end 
% end 

% numlist = {3,6,18};
% for k1 = 1:length(numlist)
%     fprintf('Number at position %d = %6.2f\n', k1, numlist{k1})
% end


fileName = "testList.txt";
names = {'Adam','Agne', 'Bradley', 'Cameron', 'Darcey', 'Dylan', 'Georgiana', 'Jack', 'James', 'Jonathan', 'Jordan', 'Liam', 'Max', 'Mikhayla', 'Rob', 'Shaun', 'Sophie', 'Tan', 'Teodora', 'Tom' };

fid = fopen(fileName, 'w');

for str = names
  for i = 1:10
   
    name = string(str);
    disp(name+i);  
    
    start = 'MFCCs/test/';
    
    fprintf(fid, '%s%s%d.mfc\n', start, string(str), i);
    
    

  end 
 
end

 fclose(fid);
