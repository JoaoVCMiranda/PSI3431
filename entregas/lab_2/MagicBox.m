function specs_vecs = MagicBox(num_usp)
a=uint32(num_usp);
specs_vecs=zeros(1,4);

for i=1:4
    b=uint32(10^(8-2*i));
    specs_vecs(i)=idivide(a,b);
    a=rem(a,b);
end

specs_vecs(1)=specs_vecs(1)/10;

if specs_vecs(3)-specs_vecs(4)<20
   specs_vecs(3)=specs_vecs(3)/2;
   specs_vecs(4)=specs_vecs(3)+specs_vecs(4);
end

if specs_vecs(4)-specs_vecs(3)<20
   specs_vecs(4)=specs_vecs(4)/2;
   specs_vecs(3)=specs_vecs(3)+specs_vecs(4);
end

if specs_vecs(3)<15
    specs_vecs(3)=specs_vecs(3)+15;
end

if specs_vecs(4)<15
    specs_vecs(4)=specs_vecs(4)+15;
end

end

