%filename:conv_new.m
function y=conv_new(h,x);
length_h=length(h);
length_x=length(x);
y_temp=zeros(length_x,length_h+length_x-1);
for i=1:length_x
    y_temp(i,:)=[zeros(1,i-1) x(i)*h zeros(1,length_x-1-(i-1))];
end
for i=1:length_x+length_h-1
    y(i)=sum(y_temp(:,i));
end