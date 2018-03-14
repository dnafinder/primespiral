function output=primespiral(varargin)
% PRIMESPIRAL Play into the world of prime numbers! 
% Primespiral is a function to explore the distribution of prime numbers 
% arranged into a spiral pattern. 
% The well-known Ulam spiral and the variant developed by Robert Sacks, 
% the Sacks spiral, show interesting geometric patterns in the positions of primes.
% 
% Syntax: primesout=primespiral(t)
% 
%     Inputs:
%           t - is an integer number. The spiral will be plotted between 0 and t
%               If t is omitted, it will be set to 3571 (between 0 and 3571
%               there are 500 prime numbers).
%     Outputs:
%           primesout - the primes of the choosed family, between 0 and t.
% 
% The function will ask if you want to use the Ulam, Sacks, Vogel or Archimede spiral.
% Then it will ask if you want to highlight a particular prime family.
% 
%     Outputs: 
%           The primes of the family you choosed between 0 and t
% 
%           Created by Giuseppe Cardillo
%           giuseppe.cardillo-edta@poste.it
% 
% To cite this file, this would be an appropriate format:
% Cardillo G. (2014) Primespiral: Play into the world of prime numbers!
% http://www.mathworks.com/matlabcentral/fileexchange/46025

p = inputParser;
addOptional(p,'x',3571,@(x) validateattributes(x,{'numeric'},{'scalar','real','finite','nonnan','positive','integer'}));
parse(p,varargin{:});
t=p.Results.x;
clear p 

spirals={'Ulam','Sacks','Vogel','Archimede'};
type=listdlg('PromptString','Select a spiral:','ListSize',[300 150],...
    'Name','Disposable spirals', 'SelectionMode','single',...
                      'ListString',spirals);
if type==4 && t>500 
    ButtonName = questdlg(sprintf('When natural numbers are > 541, this plot is a little bit confused.\n Do you want to scale down to 541?'), ...
                         'Question', 'Yes', 'No', 'Yes');
    if strcmp(ButtonName,'Yes')==1
        t=541;
    end
end

PrimesFamilies={'Only Primes',...
    'Primes and Sacks axes'...
    'Isolated primes',...
    'Twin primes',...
    'Cousin primes',...
    'Sexy primes',...
    'Primes triplets',...
    'Primes quadruplets',...
    'Sophie Germain and Safe primes',...
    'Centered triangular primes',...
    'Centered square primes'...
    'Star primes',...
    'Centered hexagonal primes',...
    'Centered heptagonal primes',...
    'Centered decagonal primes',...
    'Polygonal primes',...
    'Additive primes',...
    'Emirps',...
    'Palindromic primes',...
    'Super primes',...
    'Lucky primes'...
    'Pythagorean primes (amenable primes)',...
    'Euler primes (n^2 + n + 41)',...
    'Mersenne primes',...
    'Double Mersenne primes',...
    'Carol primes',...
    'Kynea primes',...
    'Cullen primes',...
    'Woodall primes'...
    'Cuban primes',...
    'Eisenstein primes',...
    'Fermat primes',...
    'Generalised Fermat primes base 10',...
    'Gaussian primes',...
    'Genocchi prime',...
    'Good primes',...
    'Fibonacci primes',...
    'Lucas primes',...
    'Padovan primes',...
    'Pell primes',...
    'Perrin primes',...
    'Primes n^4+1',...
    'Chen primes',...
    'Supersingular primes',...
    'Thabit primes (3*2^n + 1)',...
    'Thabit primes (3*2^n - 1)',...
    'Quartan primes',...
    'Left truncatable primes',...
    'Right truncatable primes',...
    'Two sided primes',...
    'Circular primes',...
    'Smarandache-Wellin primes',...
    'Primorial primes',...
    'Dihedral primes',...
    'Minimal primes',...
    'Idoneal primes',...
    'r-topic primes',...
    'Self primes (Colombian primes)',...
    'Bell primes',...
    };
if ~isequal(spirals{type},'Sacks')
    PrimesFamilies(2)=[];
end
selected=listdlg('PromptString','Select a primes family:','ListSize',[300 400],...
    'Name','Disposable primes families', 'SelectionMode','single',...
                      'ListString',PrimesFamilies);
                  
NN=(1:1:t)'; %Natural numbers between 1 and t
PrimesFlag=zeros(size(NN)); PrimesFlag(isprime(NN))=1;

%compute primes of selected family
switch PrimesFamilies{selected}
    case 'Only Primes'
        primesout=NN(PrimesFlag==1);
        txt={'Not primes','Primes'};
        description = {upper('Prime number'),'A prime number (or a prime) is a natural number greater than 1 that cannot be formed by multiplying two smaller natural numbers. A natural number greater than 1 that is not prime is called a composite number. For example, 5 is prime because the only ways of writing it as a product, 1 × 5 or 5 × 1, involve 5 itself. However, 6 is composite because it is the product of two numbers (2 × 3) that are both smaller than 6. Primes are central in number theory because of the fundamental theorem of arithmetic: every natural number greater than 1 is either a prime itself or can be factorized as a product of primes that is unique up to their order. There are infinitely many primes, as demonstrated by Euclid around 300 BC.'};
    case 'Primes and Sacks axes'
        primesout=NN(PrimesFlag==1);
        q=NN(NN<=max(roots([1 0 -t]))); p=polyval([1 0 0],q); PrimesFlag(p)=2;
        q=NN(NN<=max(roots([4 1 -t]))); p=polyval([4 1 0],q); PrimesFlag(p)=3;
        q=NN(NN<=max(roots([1 1 -t]))); p=polyval([1 1 0],q); PrimesFlag(p)=4;
        q=NN(NN<=max(roots([4 -1 -t]))); p=polyval([4 -1 0],q); PrimesFlag(p)=5;
        txt={'Not primes','Primes','East axes of perfect squares n^2','North axes n(4n+1)',...
            'West axes of pronic number n(n+1)','South axes n(4n-1)'};
        description = {upper('Prime number'),'A prime number (or a prime) is a natural number greater than 1 that cannot be formed by multiplying two smaller natural numbers. A natural number greater than 1 that is not prime is called a composite number. For example, 5 is prime because the only ways of writing it as a product, 1 × 5 or 5 × 1, involve 5 itself. However, 6 is composite because it is the product of two numbers (2 × 3) that are both smaller than 6. Primes are central in number theory because of the fundamental theorem of arithmetic: every natural number greater than 1 is either a prime itself or can be factorized as a product of primes that is unique up to their order. There are infinitely many primes, as demonstrated by Euclid around 300 BC.'};
    case 'Isolated primes' 
        q=repmat(NN(PrimesFlag==1),1,3)+repmat([-2 0 2],length(NN(PrimesFlag==1)),1);
        primesout=q(sum(isprime(q),2)==1,2);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Isolated primes'};
        description = {upper('Isolated primes'),'Primes p such that neither p-2 nor p+2 is primes.'};
    case 'Twin primes'
        q=repmat(NN(PrimesFlag==1),1,2)+repmat([0 2],length(NN(PrimesFlag==1)),1); 
        p=q(sum(isprime(q),2)==2); PrimesFlag(p)=2; PrimesFlag(p+2)=3; 
        primesout=[p p+2];  
        p=ismember(primesout(:,1),primesout(:,2));
        PrimesFlag(p)=4; 
        txt={'Not primes','Primes','Twin primes 1st member',...
            'Twin primes 2nd member','Members of both columns'};
        description = {upper('Twin primes'),'Primes p such that p and p+2 are both primes.'};
     case 'Cousin primes' 
        q=repmat(NN(PrimesFlag==1),1,2)+repmat([0 4],length(NN(PrimesFlag==1)),1); 
        p=q(sum(isprime(q),2)==2); PrimesFlag(p)=2; PrimesFlag(p+4)=3; 
        primesout=[p p+4]; 
        p=ismember(primesout(:,1),primesout(:,2));
        PrimesFlag(p)=4; 
        txt={'Not primes','Primes','Cousin primes 1st member',...
            'Cousin primes 2nd member','Members of both columns'};
        description = {upper('Cousin primes'),'Primes p such that p and p+4 are both primes.'};
    case 'Sexy primes' 
        q=repmat(NN(PrimesFlag==1),1,2)+repmat([0 6],length(NN(PrimesFlag==1)),1); 
        p=q(sum(isprime(q),2)==2); PrimesFlag(p)=2; PrimesFlag(p+6)=3; 
        primesout=[p p+6];
        p=ismember(primesout(:,1),primesout(:,2));
        PrimesFlag(primesout(p))=4; 
        txt={'Not primes','Primes','Sexy primes 1st member',...
            'Sexy primes 2nd member','Members of both columns'};
        description = {upper('Sexy primes'),'Primes p such that p and p+6 are both primes.'};
    case 'Primes triplets' 
        L=length(NN(PrimesFlag==1));
        q=repmat(NN(PrimesFlag==1),1,3)+repmat([0 2 6],L,1); 
        l=isprime(q); p1=q(all(l,2),:);
        q=repmat(NN(PrimesFlag==1),1,3)+repmat([0 4 6],L,1);  
        l=isprime(q); p2=q(all(l,2),:);
        PrimesFlag(p1(:,1))=2; PrimesFlag(p1(:,2))=3; PrimesFlag(p1(:,3))=4;
        PrimesFlag(p2(:,1))=2; PrimesFlag(p2(:,2))=3; PrimesFlag(p2(:,3))=4; 
        primesout=sortrows([p1;p2]);
        txt={'Not primes','Primes','Primes triplets 1st member',...
            'Primes triplets 2nd member','Primes triplets 3rd member'};
        description = {upper('Primes triplets'),'Where (p, p+2, p+6) or (p, p+4, p+6) are all primes.'};
    case 'Primes quadruplets' 
        q=repmat(NN(PrimesFlag==1),1,4)+repmat([0 2 6 8],length(NN(PrimesFlag==1)),1); 
        l=isprime(q); p=q(all(l,2),:);
        PrimesFlag(p(:,1))=2; PrimesFlag(p(:,2))=3; 
        PrimesFlag(p(:,3))=4; PrimesFlag(p(:,4))=5; 
        primesout=p;
        txt={'Not primes','Primes','Primes quadruplets 1st member',...
            'Primes quadruplets 2nd member','Primes quadruplets 3rd member',...
            'Primes quadruplets 4th member'};
        description = {upper('Primes quadruplets'),'Where (p, p+2, p+6, p+8) are all primes.'};
    case 'Sophie Germain and Safe primes'
        L=length(NN(PrimesFlag==1));
        q=repmat(NN(PrimesFlag==1),1,2).*repmat([1 2],L,1)+repmat([0 1],L,1);
        p=q(sum(isprime(q),2)==2); PrimesFlag(p)=2; PrimesFlag(2.*p+1)=3; 
        primesout=[p 2.*p+1]; 
        p=ismember(primesout(:,1),primesout(:,2));
        PrimesFlag(p)=4; 
        txt={'Not primes','Primes','Sophie Germain Primes',...
            'Safe primes','Sophie Germain AND Safe Primes'};
        description = {upper('Sophie Germain and Safe primes'),'Sophie Germain primes: Where p and 2p+1 (safe primes) are both primes.',...
            'Safe primes: Where p and (p-1)/2 (Sophie Germain primes) are both primes.'};
    case 'Centered triangular primes'
        q=NN(NN<=max(roots([3 3 2-t]))); p=polyval([3 3 2],q)/2;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2; 
        txt={'Not primes','Primes',...
            'Centered triangular primes (3n^2 + 3n + 2)/2'};
        description = {upper('Centered triangular primes'),'A centered triangular number is a centered figurate number that represents a triangle with a dot in the center and all other dots surrounding the center in successive triangular layers.',...
            'The centered triangular number for n is given by the formula (3n^2 + 3n + 2)/2.',...
        'A centered triangular prime is a centered triangular number that is prime.'};
    case 'Centered square primes'
        q=NN(NN<=max(roots([2 2 1-t]))); p=polyval([2 2 1],q);
        primesout=p(isprime(p)); PrimesFlag(primesout)=2; 
        txt={'Not primes','Primes',...
            'Centered square primes (2n^2 + 2n + 1)'};
        description = {upper('Centered square primes'),'A centered square number is a centered figurate number that represents a square with a dot in the center and all other dots surrounding the center in successive squared layers.',...
            'The centered square number for n is given by the formula (2n^2 + 2n + 1).',...
        'A centered square prime is a centered triangular number that is prime.'};
    case 'Star primes'
        q=NN(NN<=max(roots([6 -6 1-t]))); p=polyval([6 -6 1],q);
        primesout=p(isprime(p)); PrimesFlag(primesout)=2; 
        txt={'Not primes','Primes',...
            'Star primes (6n^2 - 6n + 1)'};
        description = {upper('Star primes'),'A star number is a centered figurate number that represents a centered hexagram (six-pointed star), such as the one that Chinese checkers is played on.',...
            'The star number for n is given by the formula (6n^2 - 6n + 1).',...
        'A star prime is a star number that is prime.'};
    case 'Centered hexagonal primes'
        q=NN(NN<=max(roots([3 3 1-t]))); p=polyval([3 3 1],q);
        primesout=p(isprime(p)); PrimesFlag(primesout)=2; 
        txt={'Not primes','Primes',...
            'Centered Hexagonal (or Cuban) primes (3n^2 + 3n + 1)'};
        description = {upper('Centered Hexagonal primes'),'A centered hexagonal number is a centered figurate number that represents a hexagon with a dot in the center and all other dots surrounding the center in successive hexagonal layers.',...
            'The centered hexagonal number for n is given by the formula (3n^2 + 3n + 1).',...
        'A centered hexagonal prime is a centered hexagonal number that is prime.','',...
        'A cuban prime is a prime number that is a solution to one of two different specific equations involving third powers of x and y. The first of these equations is: p = {x^3 - y^3}/{x - y} and x = y + 1, y>0  which simplifies to 3y^2 + 3y + 1.',...
        'This is exactly the general form of a centered hexagonal number; that is, all of these cuban primes are centered hexagonal.'};
    case 'Centered heptagonal primes'
        q=NN(NN<=max(roots([7 7 2-t]))); p=polyval([7 7 2],q)/2;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2; 
        txt={'Not primes','Primes',...
            'Centered heptagonal primes (7n^2 + 7n + 2)/2'};
        description = {upper('Centered heptagonal primes'),'A centered heptagonal number is a centered figurate number that represents a heptagon with a dot in the center and all other dots surrounding the center in successive heptagonal layers.',...
            'The centered heptagonal number for n is given by the formula (7n^2 - 7n + 2)/2.',...
        'A centered heptagonal prime is a centered heptagonal number that is prime.'};
    case 'Centered decagonal primes'
        %A centered decagonal number is a centered figurate number that
        %represents a decagon with a dot in the center and all other dots
        %surrounding the center dot in successive decagonal layers. The centered
        %decagonal number for n is given by the formula 5(n^2-n)+1.
        %A centered decagonal prime is a centered heptagonal number that is prime.
        q=NN(NN<=max(roots([5 -5 1-t]))); p=polyval([5 -5 1],q);
        primesout=p(isprime(p)); PrimesFlag(primesout)=2; 
        txt={'Not primes','Primes',...
            'Centered decagonal primes (5n^2 - 5n + 1)'};
        description = {upper('Centered decagonal primes'),'A centered decagonal number is a centered figurate number that represents a decagon with a dot in the center and all other dots surrounding the center in successive decagonal layers.',...
            'The centered decagonal number for n is given by the formula 5n^2 - 5n + 1.',...
        'A centered decagonal prime is a centered decagonal number that is prime.'};
     case 'Polygonal primes'
        s=str2double(cell2mat(inputdlg('Choose the number of the sides of the polygon')));
        q=floor(realsqrt(8*(s-2)*t+(s-4)^2)+(s-4))/(2*(s-2));
        x=2:1:q; p=(x.^2.*(s-2)-x.*(s-4))./2;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',sprintf('%i-gonal primes\n',s)};
        description = {upper('Polygonal primes'),'In mathematics, a polygonal number is a number represented as dots or pebbles arranged in the shape of a regular polygon. The dots are thought of as alphas (units). These are one type of 2-dimensional figurate numbers.'};
    case 'Additive primes'
        p=ones(1,sum(PrimesFlag)); pns=NN(PrimesFlag==1);
        for I=1:length(p)
            p(I)=digitsum(pns(I),1);
        end
        PrimesFlag(pns(isprime(p)))=2; primesout=NN(PrimesFlag==2);
        txt={'Not primes','Primes',...
            'Additive primes'};
        description = {upper('Additive primes'),'Primes such that the sum of digits is a prime.'};
    case 'Emirps'
        pns=NN(PrimesFlag==1);
        p=fliplr(str2num(fliplr(num2str(pns)))); %#ok<ST2NM>
        a=pns(isprime(p)); b=p(isprime(p)); c=a-b;
        primesout=a(c~=0); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Emirps'};
        description = {upper('Emirps'),'An emirp (prime spelled backwards) is a prime number that results in a different prime when its decimal digits are reversed. This definition excludes the related palindromic primes.'};
    case 'Palindromic primes'
        pns=NN(PrimesFlag==1);
        p=fliplr(str2num(fliplr(num2str(pns)))); %#ok<ST2NM>
        a=pns(isprime(p)); b=p(isprime(p)); c=a-b;
        primesout=a(c==0); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Palindromic primes'};
        description = {upper('Palindromic primes'),'Primes that remain the same when their decimal digits are read backwards.'};
    case 'Super primes'
        a=1:1:sum(PrimesFlag); 
        pns=NN(PrimesFlag==1);
        primesout=pns(isprime(a)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Super primes'};
        description = {upper('Super primes'),'Primes with a prime index in the sequence of prime numbers (the 2nd, 3rd, 5th, ... prime).'};
    case 'Lucky primes'
        q=1:1:t;
        I=2; a=q(I);
        while a<=length(q)
            q(a:a:length(q))=[];
            if q(I)~=a
                a=q(I);
            else
                I=I+1;
                a=q(I);
            end
        end
        primesout=q(isprime(q));  PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Lucky primes'};
        description = {upper('Lucky primes'),'In number theory, a lucky number is a natural number in a set which is generated by a certain "sieve". This sieve is similar to the Sieve of Eratosthenes that generates the primes, but it eliminates numbers based on their position in the remaining set, instead of their value (or position in the initial set of natural numbers).',...
'Begin with a list of integers starting with 1:',...
'1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21...',...
'Every second number (all even numbers) in the remaining list is eliminated, leaving only the odd integers:',...
'1,3,5,7,9,11,13,15,17,19,21,23,25...',...
'The second term in this sequence is 3. Starting with 5, every third number which remains in the list is eliminated:',...
'1,3,7,9,13,15,19,21,25...',...
'The next surviving number is now 7, so every seventh number that remains is eliminated:',...
'1,3,7,9,13,15,21,25...',...
'When this procedure has been carried out completely, the survivors are the lucky numbers. A lucky prime is a lucky number that is prime.'};
    case 'Pythagorean primes (amenable primes)'
        q=0:1:floor((t-1)/4); p=4.*q+1;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Pythagorean or amenable primes (4n + 1)'};
        description = {upper('Pythagorean primes'),'A Pythagorean prime is a prime number of the form 4n + 1. Pythagorean primes are exactly the odd prime numbers that are the sum of two squares. Equivalently, by the Pythagorean theorem, they are the odd prime numbers p for which p is the length of the hypotenuse of a right triangle with integer sides. For instance, the number 5 is a Pythagorean prime; 5=1^2+2^2 and 5 itself is the hypotenuse of a right triangle with sides 3 and 4.'};
    case 'Euler primes (n^2 + n + 41)'
        if t<41
            warndlg('Euler primes are >=41', 'Warning!');
        end
        q=NN(NN<=max(roots([1 1 41-t]))); p=polyval([1 1 41],q);
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Euler primes (n^2 + n + 41)'};
        description = {upper('Euler primes'),'It is known that non-constant polynomial function P(n) with integer coefficients exists that evaluates to a prime number for all integers n. Euler first noticed (in 1772) that the quadratic polynomial P(n) = n^2 + n + 41 is prime for all positive integers less than 41.'};
    case 'Mersenne primes'
        q=primes(floor(log2(t))); p=2.^q-1;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Mersenne primes (2^p - 1 with p prime number)'};
        description = {upper('Mersenne primes'),'In mathematics, a Mersenne prime is a prime number of the form M(n)=2^n-1. They are named after the French monk Marin Mersenne who studied them in the early 17th century. The first four Mersenne primes are 3, 7, 31 and 127. If n is a composite number then so is 2^n-1. The definition is therefore unchanged when written M(p)=2^p-1 where p is assumed prime. More generally, numbers of the form M(n)=2^n-1, without the primality requirement are called Mersenne numbers. Mersenne numbers are sometimes defined to have the additional requirement that n be prime, equivalently that they be pernicious Mersenne numbers, namely those pernicious numbers whose binary representation contains no zeros. The smallest composite pernicious Mersenne number is 2^11 - 1.'};
    case 'Double Mersenne primes'
        p=[7 127 2147483647 170141183460469231731687303715884105727];
        primesout=p(p<=t); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Double Mersenne primes'};
        description = {upper('Double Mersenne primes'),'In mathematics, a double Mersenne number is a Mersenne number of the form M_{M_p} = 2^{2^p-1}-1 where p is a Mersenne prime exponent.'};
    case 'Carol primes'
        q=0:1:floor(log2(1+sqrt(t+2))); p=(2.^q-1).^2-2;
        p(p<1)=[]; primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Carol primes (2^n - 1)^2 - 2'};
        description = {upper('Carol primes'),'A Carol number is an integer of the form 4^n - 2^{n + 1} - 1. A Carol prime is a Carol number that is prime.'};
    case 'Kynea primes'
        q=0:1:floor(log2(-1+sqrt(t+2))); p=(2.^q+1).^2-2;
        p(p<1)=[]; primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Kynea primes (2^n + 1)^2 - 2'};
        description = {upper('Kynea primes'),'A Kynea number is an integer of the form  4^n + 2^{n + 1} - 1. A Kynea prime is a Kynea number that is prime.'};
    case 'Cullen primes'
        q=0:1:floor(sqrt(log2(t-1))); p=q.*2.^q+1;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Cullen primes n*2^n + 1'};
        description = {upper('Cullen primes'),'A Cullen number is an integer of the form n*2^n + 1. A Cullen prime is a Cullen number that is prime.'};
    case 'Woodall primes'
        q=1:1:floor(sqrt(log2(t+1))); p=q.*2.^q-1;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Woodall primes n*2^n - 1'};
        description = {upper('Woodall primes'),'A Woodall number is an integer of the form n*2^n - 1. A Woodall prime is a Woodall number that is prime.'};
    case 'Cuban primes'
        q=2:1:floor(sqrt((t-1)/3)); p=3.*q.^2+1;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Cuban primes 3*n^2 + 1'};
        description = {upper('Cuban primes'),'A cuban prime is a prime number that is a solution to one of two different specific equations involving third powers of x and y. The first of these equations is: p = {x^3 - y^3}/{x - y} and x = y + 1, y>0 which simplifies to 3y^2 + 3y + 1. This is exactly the general form of a centered hexagonal number; that is, all of these cuban primes are centered hexagonal. The second of these equations is: p = {x^3 - y^3}/{x - y} and x = y + 2, y>0. This simplifies to 3y^2 + 6y + 4. With a substitution y = n - 1 it can also be written as 3n^2 + 1, n>1.'};
    case 'Eisenstein primes'
        q=1:1:floor((t+1)/3); p=3.*q-1;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Eisenstein primes 3*n - 1'};
        description = {upper('Eisenstein primes'),'Let w be the cube root of unity (-1+i*sqrt(3)/2 Then the Eisenstein primes are Eisenstein integers, i.e., numbers of the form a+bw for a and b integers, such that a+bw cannot be written as a product of other Eisenstein integers. The positive Eisenstein primes with zero imaginary part are precisely the ordinary primes that are:','p≡2 (mod 3)'};
    case 'Fermat primes'
        q=0:1:floor(log2(log2(t-1))); p=1+2.^(2.^q);
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Fermat primes (2^(^2^n^)) + 1'};
        description = {upper('Fermat primes'),'In mathematics, a Fermat number, named after Pierre de Fermat, is a positive integer of the form:'...
            'F(n) = 2^{(2^n)} + 1 where n is a nonnegative integer.'};
    case 'Generalised Fermat primes base 10'
        q=1:1:floor(log10(t-1)); p=10.^q+1;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Generalised Fermat primes base 10 (10^n+1)'};
        description = {upper('Generalised Fermat primes base 10'),'In mathematics, a Fermat number, named after Pierre de Fermat, is a positive integer of the form:'...
            'F(n) = b^{(b^n)} + 1 where n and b are a nonnegative integer.'};
    case 'Gaussian primes'
        q=0:1:floor((t-3)/4); p=4.*q+3;
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Gaussian primes (4n + 3)'};
        description = {upper('Gaussian primes'),'In number theory, a Gaussian integer is a complex number whose real and imaginary parts are both integers.',...
            'Gaussian primes are Gaussian integers z=a+ib satisfying one the following contitions:',...
            '1) if both a and b are nonzero then z is a Gaussian prime if a^2+b^2 is prime;',...
            '2) if a=0, then b is a Gaussian prime if |b| is prime and |b|≡3 (mod 4);',...
            '3) if b=0, then a is a Gaussian prime if |a| is prime and |a|≡3 (mod 4);'};
    case 'Genocchi prime'
        if t<17
            warndlg('The only positive prime Genocchi number is 17', 'Warning!');
        end
        primesout=17; PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Genocchi prime (17)'};
        description = {upper('Genocchi prime'),'In mathematics, the Genocchi numbers Gn, named after Angelo Genocchi, are a sequence of integers that satisfy the relation:',...
            '2t/(exp(t)+1) = sum(Gn*t^n/n!) n=1 to inf','The only positive prime that is a Genocchi number is 17.'};
    case 'Good primes'
        L=sum(PrimesFlag); pns=NN(PrimesFlag==1);
        A=L; I=2;
        while A<2*L
            q=primes(I*t);
            A=length(q);
            I=I+1;
        end
        clear A I
        idx=NaN(1,L); idx(1)=0;
        for L=2:L
            I=1:L-1;
            idx(L)=all(q(L)^2>q(L-I).*q(L+I));
        end
        primesout=pns(logical(idx)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Good primes'};
        description = {upper('Good primes'),'A good prime is a prime number whose square is greater than the product of any two primes at the same number of positions before and after it in the sequence of primes.'...
            'p(n)^2 > p(n-i)*p(n+i) for all 1 < i < n-1, where pn is the n-th prime.'};
    case 'Fibonacci primes'
        f=NaN(1,t); f0=0; f1=1; f([1 2])=[0 1]; I=3;
        while f1<=t
            f(I)=f0+f1;
            f0=f1; f1=f(I); I=I+1;
        end
        f(isnan(f))=[]; primesout=f(isprime(f)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Fibonacci primes'};
        description = {upper('Fibonacci primes'),'Primes in the Fibonacci sequence F(0) = 0, F(1) = 1, Fn = Fn-1 + Fn-2.'};
    case 'Lucas primes'
        f=NaN(1,t); f0=2; f1=1; f([1 2])=[2 1]; I=3;
        while f1<=t
            f(I)=f0+f1;
            f0=f1; f1=f(I); I=I+1;
        end
        f(isnan(f))=[]; primesout=f(isprime(f)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Lucas primes'};
        description = {upper('Lucas primes'),'Primes in the Lucas sequence L(0) = 2, L(1)= 1, Ln = L(n-1) + L(n-2).'};
    case 'Padovan primes'
        f=NaN(1,t); f(1:3)=[1 1 1]; I=4;
        while f(I-1)<=t
            f(I)=f(I-2)+f(I-3); I=I+1;
        end
        f(isnan(f))=[]; f(f>t)=[];
        primesout=unique(f(isprime(f))); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Padovan primes'};
        description = {upper('Padovan primes'),'Primes in the Padovan sequence P(0) = P(1) = P(2) = 1, P(n) = P(n-2) + P(n-3).'};
     case 'Pell primes'
        f=NaN(1,t); f0=0; f1=1; f([1 2])=[0 1]; I=3;
        while f1<=t
            f(I)=f0+2*f1;
            f0=f1; f1=f(I); I=I+1;
        end
        f(isnan(f))=[]; f(f>t)=[];
        primesout=f(isprime(f)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Pell primes'};
        description = {upper('Pell primes'),'Primes in the Pell sequence P(0) = 0, P(1) = 1, Pn = 2P(n-1) + P(n-2).'};
    case 'Perrin primes'
        f=NaN(1,t); f(1:3)=[3 0 2]; I=4;
        while f(I-1)<=t
            f(I)=f(I-2)+f(I-3); I=I+1;
        end
        f(isnan(f))=[]; f(f>t)=[];
        primesout=unique(f(isprime(f))); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Perrin primes'};
        description = {upper('Perrin primes'),'Primes in the Perrin sequence P(0) = 3, P(1) = 0, P(2) = 2, P(n) = P(n-2) + P(n-3).'};
     case 'Primes n^4+1'
        %Primes of the form n^4 + 1
        q=0:1:floor(sqrt(sqrt(t-1))); p=q.^4+1; 
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Primes n^4 + 1'};
        description = {'Primes in the form p=n^4 + 1'};
     case 'Chen primes'
        pns=NN(PrimesFlag==1);
        Idx=zeros(1,sum(PrimesFlag));
        for I=1:sum(PrimesFlag)
            Idx(I)=length(factor(pns(I)+2));
        end
        primesout=pns(Idx<=2);  PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Chen primes'};
        description = {upper('Chen primes'),'The rule is that p is prime and p+2 is either a prime or semiprime. A semiprime (also called biprime or 2-almost prime, or pq number) is a natural number that is the product of two (not necessarily distinct) prime numbers.'};
    case 'Supersingular primes'
        primesout=[2 3 5 7 11 13 17 19 23 29 31 41 47 59 71]; PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Supersingular primes'};
        description = {upper('Supersingular primes'),'In the mathematical branch of moonshine theory, a supersingular prime is a prime divisor of the order of the Monster group M, the largest of the sporadic simple groups. There are precisely 15 supersingular primes: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 41, 47, 59, and 71 and all of them also are Chen primes.'};
    case 'Thabit primes (3*2^n + 1)'
        q=0:1:floor(log2((t-1)/3)); p=3.*2.^q+1; 
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Thabit primes (3*2^n + 1)'};
        description = {'THABIT PRIMES (3*2^n + 1)','In number theory, a Thabit number, Thabit ibn Kurrah number, or 321 number is an integer of the form 3*(2^n)+1 for a non-negative integer n.'};
    case 'Thabit primes (3*2^n - 1)'
        q=0:1:floor(log2((t+1)/3)); p=3.*2.^q-1; 
        primesout=p(isprime(p)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Thabit primes (3*2^n - 1)'};
        description = {'THABIT PRIMES (3*2^n - 1)','In number theory, a Thabit number, Thabit ibn Kurrah number, or 321 number is an integer of the form 3*(2^n)-1 for a non-negative integer n.'};
    case 'Quartan primes'
        [a,b]=meshgrid(1:1:floor((t)^(1/4)));
        z=a.^4+b.^4;
        p=unique(z(isprime(z))); 
        primesout=p(p<=t); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Quartan primes (x^4+y^4)'};
        description = {upper('Quartan primes'),'A quartan prime is a prime number of the form x^4 + y^4, where x > 0, y > 0.'};
    case 'Left truncatable primes'
        Lidx=ones(1,sum(PrimesFlag)); pns=NN(PrimesFlag==1);
        for I=1:length(pns)
            q=num2str(pns(I));
            for J=1:length(q)
                if isequal(q(J),'0')
                    Lidx(I)=0;
                    break
                else
                    Lt=str2num(q(J:end)); %#ok<ST2NM>
                    if ~isprime(Lt)
                        Lidx(I)=0;
                        break
                    end
                end
            end
        end
        primesout=pns(logical(Lidx)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Left truncatable primes'};
        description = {upper('Left truncatable primes'),'Primes that remain prime when the leading decimal digit is successively removed.'};
    case 'Right truncatable primes'
        Ridx=ones(1,sum(PrimesFlag)); pns=NN(PrimesFlag==1);
        for I=1:length(pns)
            q=num2str(pns(I));
            for J=length(q):-1:1
                Rt=str2num(q(1:end-J)); %#ok<ST2NM>
                if ~isprime(Rt)
                    Ridx(I)=0;
                    break
                end
            end
        end
        primesout=pns(logical(Ridx)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Right truncatable primes'};
        description = {upper('Right truncatable primes'),'Primes that remain prime when the last decimal digit is successively removed.'};
    case 'Two sided primes'
        p=[2 3 5 7 23 37 53 73 313 317 373 797 3137 3797 739397];
        primesout=p(p<=t); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Two sided primes'};
        description = {upper('Two sided primes'),'Primes which are both left-truncatable and right-truncatable.','There are exactly fifteen two-sided primes: 2, 3, 5, 7, 23, 37, 53, 73, 313, 317, 373, 797, 3137, 3797, 739397.'};
    case 'Circular primes'
        Idx=ones(1,sum(PrimesFlag)); pns=NN(PrimesFlag==1);
        for I=1:sum(PrimesFlag)
            if pns(I)>10
                q=num2str(pns(I));
                for J=1:length(q)-1
                    p=circshift(q,[1 J]);
                    if ~isprime(str2num(p)) %#ok<ST2NM>
                        Idx(I)=0;
                        break
                    end
                end
            end
        end
        primesout=pns(logical(Idx)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Circular primes'};
        description = {upper('Circular primes'),'A circular prime number is a number that remains prime on any cyclic rotation of its digits (in base 10).'};
    case 'Smarandache-Wellin primes'
        primesout=NaN(1,sum(PrimesFlag)); pns=NN(PrimesFlag==1);
        primesout(1)=2; q='2'; I=2;
        q=strcat(q,num2str(pns(I)));
        while str2num(q)<t %#ok<ST2NM>
            if isprime(str2num(q)) %#ok<ST2NM>
                primesout(I)=str2num(q); %#ok<ST2NM>
            end
            I=I+1; q=strcat(q,num2str(pns(I)));
        end
        primesout(isnan(primesout))=[]; PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Smarandache-Wellin primes'};
        description = {upper('Smarandache-Wellin primes'),'Primes which are the concatenation of the first n primes written in decimal.'};
    case 'Primorial primes'
        p=2; I=1; primorial=[]; euclidean=[]; pns=NN(PrimesFlag==1);
        while p<=t
            p1=p-1; p2=p+1;
            if isprime(p1)
                primorial(end+1)=p1; %#ok<AGROW>
            end
            if isprime(p2)
                euclidean(end+1)=p2; %#ok<AGROW>
            end
            p=prod(pns(1:I)); I=I+1;
        end
        PrimesFlag(primorial)=2; PrimesFlag(euclidean)=3;
        txt={'Not primes','Primes',...
            'Primorial primes (p#-1)',...
            'Euclidean primes (p#+1)'};
        primesout=unique([primorial euclidean]);
        description = {upper('Primorial primes'),'In mathematics, primorial primes are prime numbers of the form pn# - 1, where pn# is the primorial of pn (that is, the product of the first n primes).','Euclidean primes are a subset of primorial primes of the form pn# + 1'};
    case 'Dihedral primes'
        Idx=zeros(1,sum(PrimesFlag)); pns=NN(PrimesFlag==1);
        for I=1:sum(PrimesFlag)
            q=num2str(pns(I));
            if isempty(regexp(q,'[34679]','once'))
                ud=fliplr(q); %upside down
                if isprime(str2double(ud)) 
                    mirrored=q;
                    I2=regexp(mirrored,'[2]');
                    I5=regexp(mirrored,'[5]');
                    mirrored(I2)='5'; mirrored(I5)='2';
                    if isprime(str2double(mirrored)) %in a mirror
                        I2=regexp(ud,'[2]');
                        I5=regexp(ud,'[5]');
                        ud(I2)='5'; ud(I5)='2';
                        if isprime(str2double(ud)) %upside down and in a mirror
                            Idx(I)=1;
                        end
                    end
                end
            end
        end
        primesout=pns(logical(Idx)); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Dihedral primes'};
        description = {upper('Dihedral primes'),'Primes that remain prime when read upside down or mirrored in a seven-segment display (a digital clock).'};
    case 'Minimal primes'
        p=[2 3 5 7 11 19 41 61 89 409 449 499 881 991 6469 6949 9001 9049 9649 9949 60649 666649 946669 60000049 66000049 66600049];
        primesout=p(p<=t); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Minimal primes'};
        description = {upper('Minimal primes'),'Primes for which there is no shorter sub-sequence of the decimal digits that form a prime. There are exactly 26 minimal primes.'};
    case 'Idoneal primes'
        p=[2 3 5 7 13 37];
        primesout=p(p<=t); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Idoneal primes'};
        description = {upper('Idoneal primes'),'A positive integer n is idoneal if it cannot be written as ab+bc+ca for integer a, b, and c with 0<a<b<c. The 65 idoneal numbers found by Gauss and Euler and conjectured to be the only such numbers (Shanks 1969) are 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 15, 16, 18, 21, 22, 24, 25, 28, 30, 33, 37, 40, 42, 45, 48, 57, 58, 60, 70, 72, 78, 85, 88, 93, 102, 105, 112, 120, 130, 133, 165, 168, 177, 190, 210, 232, 240, 253, 273, 280, 312, 330, 345, 357, 385, 408, 462, 520, 760, 840, 1320, 1365, and 1848 (OEIS A000926). It is known that if any other idoneal number exist, there can be only one more. So only 6 Idoneal numbers are prime.'};
    case 'r-topic primes'
        g=@(r,n) round(exp(sum(log(repmat(n,r,1)+repmat((0:1:r-1)',1,length(n))))-gammaln(r+1)));
        r=str2double(cell2mat(inputdlg('Choose the number of dimensions')));
        txt={'Not primes','Primes',...
            sprintf('%i-topic primes\n',r)};
        x=1:1:10; p=g(r,x); c=polyfit(x,p,4); z=max(roots(c-[zeros(1,4) t]));
        if z>t
            primesout=p(p<=t); PrimesFlag(primesout)=2;
        else
            if z<=10
                primesout=p(1:1:z); PrimesFlag(primesout)=2;
            else
                p=[p g(r,11:1:z)]; primesout=p; PrimesFlag(primesout)=2;
            end
        end
        description = {upper('r-topic primes'),'The term figurate number is used by different writers for members of different sets of numbers, generalizing from triangular numbers to different shapes (polygonal numbers) and different dimensions (polyhedral numbers). The term can mean:', ...
            '1) polygonal number','2) a number represented as a discrete r-dimensional regular geometric pattern of r-dimensional balls such as a polygonal number (for r = 2) or a polyhedral number (for r = 3).', ...
            '3) a member of the subset of the sets above containing only triangular numbers, pyramidal numbers and their analogs in other dimensions.'};
    case 'Self primes (Colombian primes)'
        Idx=zeros(1,sum(PrimesFlag)); pns=NN(PrimesFlag==1);
        Idx(1:4)=1;
        for I=5:sum(PrimesFlag)
            d=length(num2str(pns(I)));
            DR=1+mod(pns(I)-1,9);
            DRstar=(DR+9*mod(DR,2))/2;
            z=abs(pns(I)-DRstar-9.*(0:1:d));
            d=length(num2str(max(z)));
            pd=reshape(sprintf(strcat('%0',num2str(d),'d'),z),d,length(z));
            SOD=sum(double(num2str(pd)-48));
            y=DRstar+9.*(0:1:d);
            Idx(I)=all(SOD~=y);
        end
        primesout=pns(Idx==1); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Self primes (Colombian primes)'};
        description = {upper('Self primes'),'A self number, Colombian number or Devlali number is an integer that cannot be written as the sum of any other integer n and the individual digits of n. This property is specific to the base used to represent the integers. 20 is a self number (in base 10), because no such combination can be found (all n < 15 give a result < 20; all other n give a result > 20). 21 is not, because it can be written as 15 + 1 + 5 using n = 15.'};
    case 'Bell primes'
        M=zeros(13);
        M(1)=1;
        for I=2:13
            M(I,1)=M(I-1,I-1);
            for J=2:I
                M(I,J)=M(I-1,J-1)+M(I,J-1);
            end
        end
        clear I J
        B=diag(M); clear M
        A=B(isprime(B)); clear B
        primesout=A(A<t); PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',...
            'Bell primes'};
        description = {upper('Bell primes'),'The n-th Bell number is equal to the number of ways in which n objects can be partitioned into non-empty subsets. For example, B(3)=5 because the set {a, b, c} can be partitioned in 5 ways: {{a}, {b}, {c}}, {{a}, {b, c}}, {{b}, {a, c}},  {{c}, {a, b}} and {{a, b, c}}. Bell numbers exponentially rise up (B(1)=1; B(2)=2; B(3)=5; B(13)=27644437) ans so it will be very difficult to find Bell primes in our scheme. Anyway I implemented the Peirce triangle to compute Bell numbers. Bell primes are Bell numbers that are prime.'};
end

%plot choosed spiral
scrsz = get(groot,'ScreenSize'); %screensize
hFig1=figure('Color',[1 1 1],'outerposition',scrsz);

colors=[1 1 1;...%white
    0 0 1;...%blue
    1 0 0;...%red
    0 1 0;... %green
    1 1 0;...%yellow
    1 0 1;...%magenta
    0 1 1]; %cyan

if max(primesout(:))>t
    t=max(primesout(:));
end

switch spirals{type}
    case 'Ulam'
        N=ceil(sqrt(t));
        A=flipud(spiral(N));
        [~, idx] = sort(A(:));
        [yn, xn] = ind2sub([N N], idx);
        clear A N idx
        xn = xn-xn(1);
        yn = yn(1)-yn;
        if length(xn)>t
            xn=xn(1:t);
            yn=yn(1:t);
        end
        descrspiral={'ULAM SPIRAL', 'The Ulam spiral or prime spiral (in other languages also called the Ulam cloth) is a graphical depiction of the set of prime numbers, devised by mathematician Stanislaw Ulam in 1963 and popularized in Martin Gardner''s Mathematical Games column in Scientific American a short time later. It is constructed by writing the positive integers in a square spiral and specially marking the prime numbers.'};
        plot(xn,yn,'Color',[192 192 192]./256);
    case 'Sacks'
        [xs,ys]=spirale(t,spirals{type}); %coordinates of spirals
        plot(xs,ys,'Color',[192 192 192]./256);
        xn=xs((0:10:length(xs))+1); yn=ys((0:10:length(ys))+1); %coordinates of natural numbers
        descrspiral={'SACKS SPIRAL','In 1994, Robert Sacks, a software engineer, devised an original method for representing the classical number line of positive integers. He published his findings on the web in 2003. In this method, an Archimedean spiral centered on zero and making one counterclockwise rotation for each perfect square produces a remarkably organized distribution of prime and composite numbers. In some respects, this 2-dimensional "number sphere" can be thought of as a periodic table of numbers - because of the orderly patterns and progressions it reveals.'};
    case 'Vogel'
        [xs,ys]=spirale(t,spirals{type}); %coordinates of spirals
        xn=xs((0:10:length(xs))+1); yn=ys((0:10:length(ys))+1); %coordinates of natural numbers
        descrspiral={'VOGEL SPIRAL', 'Fermat spiral (also known as a parabolic spiral) follows the equation rho=sqrt(theta). It is a type of Archimedean spiral. In disc phyllotaxis (sunflower, daisy), the mesh of spirals occurs in Fibonacci numbers because divergence (angle of succession in a single spiral arrangement) approaches the golden ratio. The shape of the spirals depends on the growth of the elements generated sequentially. In mature-disc phyllotaxis, when all the elements are the same size, the shape of the spirals is that of Fermat spirals. That is because Fermat spiral traverses equal annuli in equal turns. The full model proposed by H. Vogel in 1979 is rho = c*sqrt{n},','theta = n * 137.508°, where n is the index number of the floret and c is a constant scaling factor. The angle 137.508° is the golden angle which is 2*pi/phi^2 in radians.'};
    case 'Archimede'
        [xn,yn]=spirale(t,spirals{type}); %coordinates of spirals
        descrspiral={'ARCHIMEDE SPIRAL','The Archimedean spiral (also known as the arithmetic spiral) is a spiral named after the 3rd century BC Greek mathematician Archimede. It is the locus of points corresponding to the locations over time of a point moving away from a fixed point with a constant speed along a line which rotates with constant angular velocity. The Archimedean spiral has the property that any ray from the origin intersects successive turnings of the spiral in points with a constant separation distance, hence the name "arithmetic spiral".','In this spiral, each ray is "family-digit" of base 10, with {0, 10, 20, ...} on the x-axis and rays are separated by theta=pi/5.'};
end
clear xs ys

%Plot primes
M=max(PrimesFlag);
H=zeros(M+1,1);
hold on
for I=0:M
    H(I+1)=plot(xn(PrimesFlag==I),yn(PrimesFlag==I),'o','markerfacecolor',colors(I+1,:),'markeredgecolor','k','markersize',4);
end
hold off
title(sprintf('%s Spiral of Prime Numbers between 1 and %i\n',spirals{type},t),...
    'Fontsize',14,'Fontweight','bold','Color',[0 0 0])
legend(H,txt,'Location','NorthOutside','Units','pixels')
axis square
set(findobj(hFig1, 'type','axes'),'Xcolor','w','Ycolor','w')

[T, ~] = getframe(hFig1);
xsum=sum(sum(T,3)); 
%xsum will be equal to max(xsum) wherever there is a blank column in
%   the image (rgb white is [255,255,255]). The left edge for the
%   cropped image is found by looking for the first column in which
%   xsum is less than max(xsum) and then subtracting the margin.
%   Similar code for other edges.
xleftedge=find(xsum<max(xsum),1,'first')-30;

ip=get(hFig1,'Innerposition');
% % Wrap text, also returning a new position for ht
ht1 = uicontrol('Style','Text','outerposition',[11 ip(4)/2+20 xleftedge 280],'BackgroundColor',[0 1 1]);
set(ht1,'String',textwrap(ht1,descrspiral))

ht2 = uicontrol('Style','Text','outerposition',[11 11 xleftedge ip(4)/2-20],'BackgroundColor',[0.8650 0.8110 0.4330]);
set(ht2,'String',textwrap(ht2,description))

if nargout
    output=primesout;
end
end

function [x,y]=spirale(t,s)
switch s
    case 'Sacks'
        rho=sqrt(1:0.1:t);
        theta=rho.*2*pi;
    case 'Vogel'
        rho=sqrt(1:0.1:t);
        phi=(1+sqrt(5))/2;
        theta=rho.^2.*((2*pi)/(phi^2));
    case 'Archimede'
        rho=1:0.1:(t+9)/10; 
        theta=(rho.*2*pi)+pi/5;
end
[x,y]=pol2cart(theta, rho);
end

function y=digitsum(num,f)
y=0; x=num;
while x>=1
    y=y+rem(x,10)^f;
    x = floor(x / 10);
end
end