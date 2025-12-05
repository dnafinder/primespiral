function output=primespiral(varargin)
% PRIMESPIRAL Play into the world of prime numbers!
% Primespiral is a function to explore the distribution of prime numbers
% arranged into a spiral pattern.
% The well-known Ulam spiral and the variant developed by Robert Sacks,
% the Sacks spiral, show interesting geometric patterns in the positions of primes.
%
% The function is interactive by default.
% If you provide parameters (t, 'Spiral', 'Family', or 'Interactive'),
% it can also run in a non-interactive (parametric) mode.
%
% Syntax:
%   primesout = primespiral()
%   primesout = primespiral(t)
%   primesout = primespiral(t,'Spiral',spiralName,'Family',familyName)
%   primesout = primespiral(...,'Interactive',true/false)
%
% Inputs:
%   t - integer number. The spiral will be plotted between 1 and t.
%       If t is omitted, it will be set to 3571
%       (between 1 and 3571 there are about 500 prime numbers).
%
% Name-Value pairs:
%   'Spiral'      - 'Ulam' | 'Sacks' | 'Vogel' | 'Archimede'
%   'Family'      - one of the strings in the PrimesFamilies list
%   'Interactive' - if omitted:
%                   * true when neither 'Spiral' nor 'Family' is provided
%                   * false otherwise
%
% Outputs:
%   primesout - the primes of the chosen family, between 1 and t.
%
% Created by Giuseppe Cardillo (2014)
% Updated and heavily commented by Giuseppe Cardillo (2014–2025)
% Email: giuseppe.cardillo.75@gmail.com
%
% To cite this file:
% Cardillo G. (2014–2025) Primespiral: Play into the world of prime numbers!
% Repository: https://github.com/dnafinder/primespiral

% -------------------------------------------------------------------------
% INPUT PARSING
% -------------------------------------------------------------------------
p = inputParser;
addOptional(p,'t',3571,@(x) validateattributes(x,{'numeric'},...
    {'scalar','real','finite','nonnan','positive','integer'}));
addParameter(p,'Spiral','',@(s) ischar(s) || isstring(s));
addParameter(p,'Family','',@(s) ischar(s) || isstring(s));
addParameter(p,'Interactive',[],@(x) islogical(x) && isscalar(x));
parse(p,varargin{:});

t = p.Results.t;
spiralParam = string(p.Results.Spiral);
familyParam = string(p.Results.Family);
interactiveParam = p.Results.Interactive;
clear p

if strlength(spiralParam)==0, spiralParam=""; end
if strlength(familyParam)==0, familyParam=""; end

if isempty(interactiveParam)
    interactive = (spiralParam=="" && familyParam=="");
else
    interactive = interactiveParam;
end

% -------------------------------------------------------------------------
% SPIRALS LIST
% -------------------------------------------------------------------------
spirals={'Ulam','Sacks','Vogel','Archimede'};

% -------------------------------------------------------------------------
% PRIME FAMILIES LIST
% -------------------------------------------------------------------------
PrimesFamilies={'Only Primes',...
    'Primes and Sacks axes'...
    'Additive primes',...
    'Balanced primes',...
    'Bell primes',...
    'Carol primes',...
    'Centered decagonal primes',...
    'Centered heptagonal primes',...
    'Centered hexagonal primes',...
    'Centered square primes'...
    'Centered triangular primes',...
    'Chen primes',...
    'Circular primes',...
    'Cousin primes',...
    'Cuban primes',...
    'Cullen primes',...
    'Dihedral primes',...
    'Double Mersenne primes',...
    'Eisenstein primes',...
    'Emirps',...
    'Euler primes (n^2 + n + 41)',...
    'Fermat primes',...
    'Fibonacci primes',...
    'Gaussian primes',...
    'Generalised Fermat primes base 10',...
    'Genocchi prime',...
    'Good primes',...
    'Happy primes'...
    'Idoneal primes',...
    'Isolated primes',...
    'Kynea primes',...
    'Left truncatable primes',...
    'Lucas primes',...
    'Lucky primes'...
    'Mersenne primes',...
    'Minimal primes',...
    'Moser primes',...
    'Padovan primes',...
    'Palindromic primes',...
    'Pell primes',...
    'Perrin primes',...
    'Polygonal primes',...
    'Primes n^4+1',...
    'Primes quadruplets',...
    'Primes triplets',...
    'Primorial primes',...
    'Pythagorean primes (amenable primes)',...
    'Quartan primes',...
    'Right truncatable primes',...
    'r-topic primes',...
    'Self primes (Colombian primes)',...
    'Sexy primes',...
    'Smarandache-Wellin primes',...
    'Sophie Germain and Safe primes',...
    'Star primes',...
    'Super primes',...
    'Supersingular primes',...
    'Thabit primes (3*2^n + 1)',...
    'Thabit primes (3*2^n - 1)',...
    'Twin primes',...
    'Two sided primes',...
    'Woodall primes'...
    };

% -------------------------------------------------------------------------
% CHOOSE SPIRAL / FAMILY
% -------------------------------------------------------------------------
if interactive
    type=listdlg('PromptString','Select a spiral:','ListSize',[300 150],...
        'Name','Disposable spirals', 'SelectionMode','single',...
        'ListString',spirals);

    if isempty(type)
        if nargout, output=[]; end
        return
    end

    % Archimede (base-10 rays) can become visually crowded.
    if type==4 && t>541
        ButtonName = questdlg(sprintf([...
            'When natural numbers are > 541, this plot can be visually crowded.\n',...
            'Do you want to scale down to 541?']), ...
            'Question', 'Yes', 'No', 'Yes');
        if strcmp(ButtonName,'Yes')
            t=541;
        end
    end

    % "Primes and Sacks axes" is meaningful only for Sacks spiral.
    if ~isequal(spirals{type},'Sacks')
        PrimesFamilies(2)=[];
    end

    selected=listdlg('PromptString','Select a primes family:','ListSize',[300 400],...
        'Name','Disposable primes families', 'SelectionMode','single',...
        'ListString',PrimesFamilies);

    if isempty(selected)
        if nargout, output=[]; end
        return
    end
else
    if spiralParam==""
        spiralParam="Ulam";
    end
    type=find(strcmpi(spiralParam,spirals),1);
    if isempty(type)
        error('primespiral:InvalidSpiral',...
            'Unknown spiral "%s". Valid options are: Ulam, Sacks, Vogel, Archimede.', spiralParam);
    end

    if ~isequal(spirals{type},'Sacks')
        PrimesFamilies(2)=[];
    end

    if familyParam==""
        familyParam="Only Primes";
    end
    selected=find(strcmpi(familyParam,PrimesFamilies),1);
    if isempty(selected)
        warning('primespiral:InvalidFamily',...
            'Unknown family "%s". Falling back to "Only Primes".', familyParam);
        selected=find(strcmp(PrimesFamilies,'Only Primes'),1);
    end
end

% -------------------------------------------------------------------------
% PRECOMPUTE NATURAL NUMBERS AND BASE PRIMES
% -------------------------------------------------------------------------
NN=(1:1:t)'; % Natural numbers between 1 and t
PrimesFlag=zeros(size(NN));
PrimesFlag(isprime(NN))=1;
pns=NN(PrimesFlag==1);

% -------------------------------------------------------------------------
% COMPUTE PRIMES OF SELECTED FAMILY
% Each case begins with an explicit, plain-text definition.
% -------------------------------------------------------------------------
switch PrimesFamilies{selected}

    case 'Only Primes'
        % Definition:
        %   Standard prime numbers in the explored interval.
        primesout=pns;
        txt={'Not primes','Primes'};
        description={upper('Prime numbers'),...
            'Standard prime numbers in the explored interval.'};

    case 'Primes and Sacks axes'
        % Definition:
        %   This is a Sacks-spiral visualization mode.
        %   It highlights primes together with four classical Sacks axes
        %   generated by simple quadratic/figurative sequences.
        primesout=pns;

        q=NN(NN<=max(roots([1 0 -t]))); p=polyval([1 0 0],q); PrimesFlag(p)=2;
        q=NN(NN<=max(roots([4 1 -t]))); p=polyval([4 1 0],q); PrimesFlag(p)=3;
        q=NN(NN<=max(roots([1 1 -t]))); p=polyval([1 1 0],q); PrimesFlag(p)=4;
        q=NN(NN<=max(roots([4 -1 -t]))); p=polyval([4 -1 0],q); PrimesFlag(p)=5;

        txt={'Not primes','Primes','East axis of perfect squares n^2',...
            'North axis n(4n+1)','West axis of pronic numbers n(n+1)',...
            'South axis n(4n-1)'};
        description={upper('Sacks axes'),...
            'Highlights primes plus the four classical Sacks axes.'};

    case 'Additive primes'
        % Definition:
        %   Additive primes are primes whose sum of decimal digits is also prime.
        s=zeros(size(pns));
        for I=1:numel(pns)
            s(I)=digitsum(pns(I),1);
        end
        primesout=pns(isprime(s));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Additive primes'};
        description={upper('Additive primes'),...
            'Primes whose digit sum is also prime.'};

    case 'Balanced primes'
        % Definition:
        %   Balanced primes are primes equal to the arithmetic mean of the nearest
        %   prime before and the nearest prime after them.
        Idx=false(size(pns));
        for I=2:numel(pns)-1
            if pns(I)==(pns(I-1)+pns(I+1))/2
                Idx(I)=true;
            end
        end
        primesout=pns(Idx);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Balanced primes'};
        description={upper('Balanced primes'),...
            'Primes equal to the mean of adjacent primes.'};

    case 'Bell primes'
        % Definition:
        %   Bell primes are Bell numbers that are prime.
        %   A Bell number counts the partitions of a set of n labeled elements
        %   into non-empty subsets.
        M=zeros(13);
        M(1)=1;
        for I=2:13
            M(I,1)=M(I-1,I-1);
            for J=2:I
                M(I,J)=M(I-1,J-1)+M(I,J-1);
            end
        end
        B=diag(M);
        primesout=B(isprime(B) & B<=t);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Bell primes'};
        description={upper('Bell primes'),...
            'Bell numbers that are prime (small range).'};

    case 'Carol primes'
        % Definition:
        %   Carol primes are primes of the form (2^n - 1)^2 - 2.
        q=0:1:floor(log2(1+sqrt(t+2)));
        p=(2.^q-1).^2-2;
        p(p<1)=[];
        primesout=p(isprime(p) & p<=t);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Carol primes'};
        description={upper('Carol primes'),...
            'Primes of the form (2^n - 1)^2 - 2.'};

    case 'Centered decagonal primes'
        % Definition:
        %   Centered decagonal primes are centered decagonal numbers
        %   of the form 5n^2 - 5n + 1 that are prime.
        q=NN(NN<=max(roots([5 -5 1-t])));
        p=polyval([5 -5 1],q);
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Centered decagonal primes'};
        description={upper('Centered decagonal primes'),...
            'Centered decagonal numbers that are prime.'};

    case 'Centered heptagonal primes'
        % Definition:
        %   Centered heptagonal primes are centered heptagonal numbers
        %   of the form (7n^2 + 7n + 2)/2 that are prime.
        q=NN(NN<=max(roots([7 7 2-t])));
        p=polyval([7 7 2],q)/2;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Centered heptagonal primes'};
        description={upper('Centered heptagonal primes'),...
            'Centered heptagonal numbers that are prime.'};

    case 'Centered hexagonal primes'
        % Definition:
        %   Centered hexagonal primes are centered hexagonal numbers
        %   of the form 3n^2 + 3n + 1 that are prime.
        q=NN(NN<=max(roots([3 3 1-t])));
        p=polyval([3 3 1],q);
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Centered hexagonal primes'};
        description={upper('Centered hexagonal primes'),...
            'Centered hexagonal numbers that are prime.'};

    case 'Centered square primes'
        % Definition:
        %   Centered square primes are centered square numbers
        %   of the form 2n^2 + 2n + 1 that are prime.
        q=NN(NN<=max(roots([2 2 1-t])));
        p=polyval([2 2 1],q);
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Centered square primes'};
        description={upper('Centered square primes'),...
            'Centered square numbers that are prime.'};

    case 'Centered triangular primes'
        % Definition:
        %   Centered triangular primes are centered triangular numbers
        %   of the form (3n^2 + 3n + 2)/2 that are prime.
        q=NN(NN<=max(roots([3 3 2-t])));
        p=polyval([3 3 2],q)/2;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Centered triangular primes'};
        description={upper('Centered triangular primes'),...
            'Centered triangular numbers that are prime.'};

    case 'Chen primes'
        % Definition:
        %   Chen primes are primes p such that p+2 is prime or semiprime.
        Idx=zeros(size(pns));
        for I=1:numel(pns)
            Idx(I)=length(factor(pns(I)+2));
        end
        primesout=pns(Idx<=2);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Chen primes'};
        description={upper('Chen primes'),...
            'Primes p where p+2 is prime or semiprime.'};

    case 'Circular primes'
        % Definition:
        %   Circular primes remain prime under all cyclic rotations of their decimal digits.
        Idx=true(size(pns));
        for I=1:numel(pns)
            if pns(I)>10
                q=num2str(pns(I));
                for J=1:length(q)-1
                    r=circshift(q,[1 J]);
                    if ~isprime(str2double(r))
                        Idx(I)=false; break
                    end
                end
            end
        end
        primesout=pns(Idx);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Circular primes'};
        description={upper('Circular primes'),...
            'Primes stable under all cyclic digit rotations.'};

    case 'Cousin primes'
        % Definition:
        %   Cousin primes are pairs of primes (p, p+4).
        q=repmat(pns,1,2)+repmat([0 4],numel(pns),1);
        p=q(sum(isprime(q),2)==2,1);
        primesout=[p p+4];
        PrimesFlag(p)=2; PrimesFlag(p+4)=3;
        txt={'Not primes','Primes','Cousin primes 1st member','Cousin primes 2nd member'};
        description={upper('Cousin primes'),...
            'Pairs of primes separated by 4.'};

    case 'Cuban primes'
        % Definition:
        %   Cuban primes satisfy specific cubic-difference identities.
        %   This explorer highlights the common quadratic form 3n^2 + 1 (n > 1).
        q=2:1:floor(sqrt((t-1)/3));
        p=3.*q.^2+1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Cuban primes'};
        description={upper('Cuban primes'),...
            'This implementation highlights the 3n^2 + 1 Cuban form.'};

    case 'Cullen primes'
        % Definition:
        %   Cullen primes are primes of the form n*2^n + 1.
        q=0:1:floor(sqrt(log2(t-1)));
        p=q.*2.^q+1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Cullen primes'};
        description={upper('Cullen primes'),...
            'Primes of the form n*2^n + 1.'};

    case 'Dihedral primes'
        % Definition:
        %   Dihedral primes remain prime when read upside down and mirrored
        %   on a seven-segment display.
        Idx=false(size(pns));
        for I=1:numel(pns)
            q=num2str(pns(I));
            if isempty(regexp(q,'[34679]','once'))
                ud=fliplr(q);
                if isprime(str2double(ud))
                    mirrored=q;
                    I2=regexp(mirrored,'2'); I5=regexp(mirrored,'5');
                    mirrored(I2)='5'; mirrored(I5)='2';
                    if isprime(str2double(mirrored))
                        I2=regexp(ud,'2'); I5=regexp(ud,'5');
                        ud(I2)='5'; ud(I5)='2';
                        if isprime(str2double(ud))
                            Idx(I)=true;
                        end
                    end
                end
            end
        end
        primesout=pns(Idx);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Dihedral primes'};
        description={upper('Dihedral primes'),...
            'Primes that survive upside-down and mirror reading on 7-segment displays.'};

    case 'Double Mersenne primes'
        % Definition:
        %   Double Mersenne primes are double Mersenne numbers that are prime.
        %   This explorer uses a short known list.
        p=[7 127 2147483647 170141183460469231731687303715884105727];
        primesout=p(p<=t);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Double Mersenne primes'};
        description={upper('Double Mersenne primes'),...
            'Known double Mersenne primes within numeric range.'};

    case 'Eisenstein primes'
        % Definition:
        %   Eisenstein primes (real-axis subset) correspond to ordinary primes congruent to 2 mod 3.
        q=1:1:floor((t+1)/3);
        p=3.*q-1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Eisenstein primes'};
        description={upper('Eisenstein primes'),...
            'Ordinary primes congruent to 2 mod 3.'};

    case 'Emirps'
        % Definition:
        %   Emirps are primes that yield a different prime when reversed in base 10.
        revp = arrayfun(@(x) str2double(fliplr(num2str(x))), pns);
        isrevprime = isprime(revp);
        primesout = pns(isrevprime & (revp~=pns));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Emirps'};
        description={upper('Emirps'),...
            'Non-palindromic primes whose digit reverse is also prime.'};

    case 'Euler primes (n^2 + n + 41)'
        % Definition:
        %   Euler primes are prime values of the polynomial n^2 + n + 41 for positive integers n.
        if t<41
            warndlg('Euler primes are >=41', 'Warning!');
        end
        q=NN(NN<=max(roots([1 1 41-t])));
        p=polyval([1 1 41],q);
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Euler primes'};
        description={upper('Euler primes'),...
            'Prime values generated by n^2 + n + 41.'};

    case 'Fermat primes'
        % Definition:
        %   Fermat primes are Fermat numbers 1 + 2^(2^n) that are prime.
        q=0:1:floor(log2(log2(t-1)));
        p=1+2.^(2.^q);
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Fermat primes'};
        description={upper('Fermat primes'),...
            'Fermat numbers that are prime within range.'};

    case 'Fibonacci primes'
        % Definition:
        %   Fibonacci primes are primes that appear in the Fibonacci sequence.
        f=[]; f0=0; f1=1;
        while f1<=t
            f(end+1)=f1; %#ok<AGROW>
            f2=f0+f1; f0=f1; f1=f2;
        end
        f=unique(f);
        primesout=f(isprime(f));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Fibonacci primes'};
        description={upper('Fibonacci primes'),...
            'Primes occurring in the Fibonacci sequence.'};

    case 'Gaussian primes'
        % Definition:
        %   Gaussian primes (real-axis subset) correspond to ordinary primes congruent to 3 mod 4.
        q=0:1:floor((t-3)/4);
        p=4.*q+3;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Gaussian primes'};
        description={upper('Gaussian primes'),...
            'Ordinary primes congruent to 3 mod 4.'};

    case 'Generalised Fermat primes base 10'
        % Definition:
        %   This explorer highlights primes of the form 10^n + 1 within the explored interval.
        q=1:1:floor(log10(t-1));
        p=10.^q+1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Base-10 generalised Fermat primes'};
        description={upper('Generalised Fermat primes base 10'),...
            'Primes of the form 10^n + 1 within range.'};

    case 'Genocchi prime'
        % Definition:
        %   Genocchi numbers are a sequence of integers related to Bernoulli numbers
        %   and to the expansion of the function 2t/(exp(t)+1).
        %   In this explorer we only need the key fact for the prime-family view:
        %   the only positive Genocchi number that is also prime is 17.
        %   Therefore the "Genocchi prime" family is a singleton {17} within range.
        if t<17
            warndlg('The only positive prime Genocchi number is 17', 'Warning!');
        end
        primesout=17;
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Genocchi prime'};
        description={upper('Genocchi prime'),...
            'The only positive Genocchi number that is prime is 17.'};

    case 'Good primes'
        % Definition:
        %   Good primes are primes whose square is greater than the product
        %   of any two primes equidistant from them in the ordered prime list.
        goodPrimes = [];
        for n = 2:length(pns)
            currentPrime = pns(n);
            isGood = true;
            for I = 1:n-1
                if (n-I < 1) || (n+I > length(pns))
                    isGood=false;
                    continue;
                end
                leftPrime = pns(n-I);
                rightPrime = pns(n+I);
                if currentPrime^2 <= leftPrime * rightPrime
                    isGood = false;
                    break;
                end
            end
            if isGood
                goodPrimes(end+1) = currentPrime; %#ok<AGROW>
            end
        end
        primesout=goodPrimes;
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Good primes'};
        description={upper('Good primes'),...
            'Primes whose square exceeds products of equidistant neighbors.'};

    case 'Happy primes'
        % Definition:
        %   Happy primes are primes that are also happy numbers.
        %   A happy number eventually reaches 1 when iterating the sum of squares of digits.
        pns2=NN(isprime(NN));
        looping=[4 16 20 37 42 58 89 145];
        happyFlag=false(size(NN));
        while ~isempty(pns2)
            a=pns2(1); seq=a; flag=0; happy=0;
            while ~flag && ~happy
                b=digitsum(a,2); seq(end+1)=b; %#ok<AGROW>
                if ismember(b,looping)
                    flag=1;
                    pns2(ismember(pns2,seq(isprime(seq))))=[];
                elseif b==1
                    happy=1;
                    happyFlag(seq(isprime(seq) & seq<=t))=true;
                    pns2(ismember(pns2,seq(isprime(seq))))=[];
                else
                    a=b;
                end
            end
        end
        primesout=NN(happyFlag);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Happy primes'};
        description={upper('Happy primes'),...
            'Primes that are also happy numbers.'};

    case 'Idoneal primes'
        % Definition:
        %   Idoneal primes are those idoneal numbers that are prime.
        p=[2 3 5 7 13 37];
        primesout=p(p<=t);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Idoneal primes'};
        description={upper('Idoneal primes'),...
            'Known small idoneal numbers that are prime.'};

    case 'Isolated primes'
        % Definition:
        %   Isolated primes are primes p such that neither p-2 nor p+2 is prime.
        q=repmat(pns,1,3)+repmat([-2 0 2],length(pns),1);
        primesout=q(sum(isprime(q),2)==1,2);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Isolated primes'};
        description={upper('Isolated primes'),...
            'Primes with no twin-prime neighbor.'};

    case 'Kynea primes'
        % Definition:
        %   Kynea primes are primes of the form (2^n + 1)^2 - 2.
        q=0:1:floor(log2(-1+sqrt(t+2)));
        p=(2.^q+1).^2-2; p(p<1)=[];
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Kynea primes'};
        description={upper('Kynea primes'),...
            'Primes of the form (2^n + 1)^2 - 2.'};

    case 'Left truncatable primes'
        % Definition:
        %   Left truncatable primes remain prime when leading digits are successively removed.
        Lidx=true(size(pns));
        for I=1:length(pns)
            q=num2str(pns(I));
            for J=1:length(q)
                if q(J)=='0'
                    Lidx(I)=false; break
                end
                Lt=str2double(q(J:end));
                if ~isprime(Lt)
                    Lidx(I)=false; break
                end
            end
        end
        primesout=pns(Lidx);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Left truncatable primes'};
        description={upper('Left truncatable primes'),...
            'Primes that stay prime when removing leading digits.'};

    case 'Lucas primes'
        % Definition:
        %   Lucas primes are primes that appear in the Lucas sequence.
        f=[]; f0=2; f1=1;
        while f0<=t
            f(end+1)=f0; %#ok<AGROW>
            f2=f0+f1; f0=f1; f1=f2;
        end
        f=unique(f);
        primesout=f(isprime(f));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Lucas primes'};
        description={upper('Lucas primes'),...
            'Primes occurring in the Lucas sequence.'};

    case 'Lucky primes'
        % Definition:
        %   Lucky primes are lucky numbers generated by the lucky sieve that are prime.
        q=1:1:t;
        I=2; a=q(I);
        while a<=length(q) && I<=length(q)
            q(a:a:length(q))=[];
            if I>length(q), break; end
            if q(I)~=a
                a=q(I);
            else
                I=I+1;
                if I>length(q), break; end
                a=q(I);
            end
        end
        primesout=q(isprime(q));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Lucky primes'};
        description={upper('Lucky primes'),...
            'Lucky numbers that are prime.'};

    case 'Mersenne primes'
        % Definition:
        %   Mersenne primes are primes of the form 2^p - 1.
        q=1:1:floor(log2(t));
        p=2.^q-1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Mersenne primes'};
        description={upper('Mersenne primes'),...
            'Primes of the form 2^p - 1 within range.'};

    case 'Minimal primes'
        % Definition:
        %   Minimal primes are primes with no shorter contiguous decimal digit subsequence that is prime.
        p=[2 3 5 7 11 19 41 61 89 409 449 499 881 991 6469 6949 9001 9049 9649 9949 60649 666649 946669 60000049 66000049 66600049];
        primesout=p(p<=t);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Minimal primes'};
        description={upper('Minimal primes'),...
            'Known list of minimal primes within range.'};

    case 'Moser primes'
        % Definition:
        %   Moser primes are prime values of the region-count sequence from Moser''s circle problem.
        l=floor(max(roots([1 -6 +23 -18 -24*(t-1)])));
        n=1:1:l;
        B=n./24.*(n.^3-6.*n.^2+23*n-18)+1;
        primesout=B(isprime(B) & B<=t);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Moser primes'};
        description={upper('Moser primes'),...
            'Prime values from Moser''s circle problem formula.'};

    case 'Padovan primes'
        % Definition:
        %   Padovan primes are primes that appear in the Padovan sequence.
        f=NaN(1,t); f(1:3)=[1 1 1]; I=4;
        while f(I-1)<=t
            f(I)=f(I-2)+f(I-3); I=I+1;
            if I>t, break; end
        end
        f(isnan(f))=[]; f(f>t)=[];
        primesout=unique(f(isprime(f)));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Padovan primes'};
        description={upper('Padovan primes'),...
            'Primes occurring in the Padovan sequence.'};

    case 'Palindromic primes'
        % Definition:
        %   Palindromic primes are primes that read the same forward and backward in base 10.
        rp = arrayfun(@(x) str2double(fliplr(num2str(x))), pns);
        primesout=pns(rp==pns);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Palindromic primes'};
        description={upper('Palindromic primes'),...
            'Primes that are palindromes in base 10.'};

    case 'Pell primes'
        % Definition:
        %   Pell primes are primes that appear in the Pell sequence.
        f=[]; f0=0; f1=1;
        while f1<=t
            f(end+1)=f1; %#ok<AGROW>
            f2=f0+2*f1; f0=f1; f1=f2;
        end
        f=unique(f);
        primesout=f(isprime(f));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Pell primes'};
        description={upper('Pell primes'),...
            'Primes occurring in the Pell sequence.'};

    case 'Perrin primes'
        % Definition:
        %   Perrin primes are primes that appear in the Perrin sequence.
        f=NaN(1,t); f(1:3)=[3 0 2]; I=4;
        while f(I-1)<=t
            f(I)=f(I-2)+f(I-3); I=I+1;
            if I>t, break; end
        end
        f(isnan(f))=[]; f(f>t)=[];
        primesout=unique(f(isprime(f)));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Perrin primes'};
        description={upper('Perrin primes'),...
            'Primes occurring in the Perrin sequence.'};

    case 'Polygonal primes'
        % Definition:
        %   Polygonal primes are polygonal numbers with s sides that are prime.
        %   The number of sides is chosen by the user.
        s=str2double(cell2mat(inputdlg('Choose the number of the sides of the polygon')));
        if isempty(s) || isnan(s) || s<3
            if nargout, output=[]; end
            return
        end
        q=floor((realsqrt(8*(s-2)*t+(s-4)^2)+(s-4))/(2*(s-2)));
        x=2:1:q;
        p=(x.^2.*(s-2)-x.*(s-4))./2;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',sprintf('%i-gonal primes',s)};
        description={upper('Polygonal primes'),...
            'Polygonal numbers for the chosen s that are prime.'};

    case 'Primes n^4+1'
        % Definition:
        %   Primes of the form n^4 + 1.
        q=0:1:floor(sqrt(sqrt(t-1)));
        p=q.^4+1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Primes n^4+1'};
        description={upper('Primes n^4+1'),...
            'Primes of the form n^4 + 1.'};

    case 'Primes quadruplets'
        % Definition:
        %   Prime quadruplets are (p, p+2, p+6, p+8) all prime.
        q=repmat(pns,1,4)+repmat([0 2 6 8],length(pns),1);
        l=isprime(q);
        p=q(all(l,2),:);
        primesout=p;
        if ~isempty(p)
            PrimesFlag(p(:,1))=2; PrimesFlag(p(:,2))=3;
            PrimesFlag(p(:,3))=4; PrimesFlag(p(:,4))=5;
        end
        txt={'Not primes','Primes','Quadruplets 1st member',...
            'Quadruplets 2nd member','Quadruplets 3rd member','Quadruplets 4th member'};
        description={upper('Prime quadruplets'),...
            'Four primes in the classic (0,2,6,8) pattern.'};

    case 'Primes triplets'
        % Definition:
        %   Prime triplets are (p, p+2, p+6) or (p, p+4, p+6) all prime.
        L=length(pns);
        q=repmat(pns,1,3)+repmat([0 2 6],L,1);
        l=isprime(q); p1=q(all(l,2),:);
        q=repmat(pns,1,3)+repmat([0 4 6],L,1);
        l=isprime(q); p2=q(all(l,2),:);
        primesout=sortrows([p1;p2]);
        if ~isempty(primesout)
            PrimesFlag(primesout(:,1))=2;
            PrimesFlag(primesout(:,2))=3;
            PrimesFlag(primesout(:,3))=4;
        end
        txt={'Not primes','Primes','Triplets 1st member','Triplets 2nd member','Triplets 3rd member'};
        description={upper('Prime triplets'),...
            'Three primes in classic triplet gap patterns.'};

    case 'Primorial primes'
        % Definition:
        %   Primorial primes are primes adjacent to primorial values p#.
        %   This explorer highlights p# - 1 and p# + 1 when they are prime.
        P=2; I=1; primorial=[]; euclidean=[];
        while P<=t && I<=numel(pns)
            Pm=P-1; Pp=P+1;
            if isprime(Pm), primorial(end+1)=Pm; end %#ok<AGROW>
            if isprime(Pp), euclidean(end+1)=Pp; end %#ok<AGROW>
            P=prod(pns(1:I)); I=I+1;
        end
        primorial=unique(primorial); euclidean=unique(euclidean);
        primorial=primorial(primorial<=t);
        euclidean=euclidean(euclidean<=t);
        primesout=unique([primorial euclidean]);
        PrimesFlag(primorial)=2; PrimesFlag(euclidean)=3;
        txt={'Not primes','Primes','Primorial primes (p#-1)','Euclidean primes (p#+1)'};
        description={upper('Primorial primes'),...
            'Primes of the form p# - 1 or p# + 1 within range.'};

    case 'Pythagorean primes (amenable primes)'
        % Definition:
        %   Pythagorean (amenable) primes are primes of the form 4n + 1.
        q=0:1:floor((t-1)/4);
        p=4.*q+1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Pythagorean primes'};
        description={upper('Pythagorean primes'),...
            'Primes congruent to 1 mod 4.'};

    case 'Quartan primes'
        % Definition:
        %   Quartan primes are primes of the form x^4 + y^4 for positive integers x and y.
        [a,b]=meshgrid(1:1:floor((t)^(1/4)));
        z=a.^4+b.^4;
        p=unique(z(isprime(z)));
        primesout=p(p<=t);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Quartan primes'};
        description={upper('Quartan primes'),...
            'Primes representable as x^4 + y^4.'};

    case 'Right truncatable primes'
        % Definition:
        %   Right truncatable primes remain prime when trailing digits are successively removed.
        Ridx=true(size(pns));
        for I=1:length(pns)
            q=num2str(pns(I));
            for J=length(q):-1:2
                Rt=str2double(q(1:J-1));
                if ~isprime(Rt)
                    Ridx(I)=false; break
                end
            end
        end
        primesout=pns(Ridx);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Right truncatable primes'};
        description={upper('Right truncatable primes'),...
            'Primes that stay prime when removing trailing digits.'};

    case 'r-topic primes'
        % Definition:
        %   r-topic primes are prime values of r-dimensional figurate number sequences.
        %   The dimension r is chosen by the user.
        g=@(r,n) round(exp(sum(log(repmat(n,r,1)+repmat((0:1:r-1)',1,length(n))))-gammaln(r+1)));
        r=str2double(cell2mat(inputdlg('Choose the number of dimensions')));
        if isempty(r) || isnan(r) || r<1
            if nargout, output=[]; end
            return
        end
        x=1:1:10;
        p=g(r,x);
        c=polyfit(x,p,4);
        z=max(roots(c-[zeros(1,4) t]));
        if z>t
            primesout=p(p<=t);
        else
            z=floor(max(1,min(z,200))); % safety cap for UI smoothness
            if z<=10
                primesout=p(1:1:z);
            else
                primesout=[p g(r,11:1:z)];
            end
        end
        primesout=primesout(isprime(primesout));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes',sprintf('%i-topic primes',r)};
        description={upper('r-topic primes'),...
            'Figurate numbers in r dimensions that are prime.'};

    case 'Self primes (Colombian primes)'
        % Definition:
        %   Self (Colombian) primes are primes that are also self numbers in base 10.
        %   A self number cannot be written as n plus the sum of the decimal digits of n.
        Idx=false(size(pns));
        Idx(1:min(4,numel(pns)))=true;
        for I=5:numel(pns)
            d=length(num2str(pns(I)));
            DR=1+mod(pns(I)-1,9);
            DRstar=(DR+9*mod(DR,2))/2;
            z=abs(pns(I)-DRstar-9.*(0:1:d));
            d2=length(num2str(max(z)));
            pd=reshape(sprintf(strcat('%0',num2str(d2),'d'),z),d2,length(z));
            SOD=sum(double(pd)-48);
            y=DRstar+9.*(0:1:d2);
            Idx(I)=all(SOD~=y);
        end
        primesout=pns(Idx);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Self primes'};
        description={upper('Self primes'),...
            'Primes that are also self numbers in base 10.'};

    case 'Sexy primes'
        % Definition:
        %   Sexy primes are pairs of primes (p, p+6).
        q=repmat(pns,1,2)+repmat([0 6],length(pns),1);
        p=q(sum(isprime(q),2)==2,1);
        primesout=[p p+6];
        PrimesFlag(p)=2; PrimesFlag(p+6)=3;
        txt={'Not primes','Primes','Sexy primes 1st member','Sexy primes 2nd member'};
        description={upper('Sexy primes'),...
            'Pairs of primes separated by 6.'};

    case 'Smarandache-Wellin primes'
        % Definition:
        %   Smarandache-Wellin primes are primes formed by concatenating the first n primes in decimal.
        primesout=[];
        qstr='2'; I=2;
        while true
            val=str2double(qstr);
            if ~isfinite(val) || val>t
                break
            end
            if isprime(val)
                primesout(end+1)=val; %#ok<AGROW>
            end
            if I>numel(pns), break; end
            qstr=strcat(qstr,num2str(pns(I)));
            I=I+1;
        end
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Smarandache-Wellin primes'};
        description={upper('Smarandache-Wellin primes'),...
            'Primes that are concatenations of the first n primes.'};

    case 'Sophie Germain and Safe primes'
        % Definition:
        %   Sophie Germain primes are primes p such that 2p+1 is also prime.
        %   The primes 2p+1 are called safe primes.
        q=repmat(pns,1,2).*repmat([1 2],length(pns),1)+repmat([0 1],length(pns),1);
        p=q(sum(isprime(q),2)==2,1);
        primesout=[p 2.*p+1];
        PrimesFlag(p)=2; PrimesFlag(2.*p+1)=3;
        txt={'Not primes','Primes','Sophie Germain primes','Safe primes'};
        description={upper('Sophie Germain and Safe primes'),...
            'Pairs (p, 2p+1) where both are prime.'};

    case 'Star primes'
        % Definition:
        %   Star primes are star numbers of the form 6n^2 - 6n + 1 that are prime.
        q=NN(NN<=max(roots([6 -6 1-t])));
        p=polyval([6 -6 1],q);
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Star primes'};
        description={upper('Star primes'),...
            'Star numbers that are prime.'};

    case 'Super primes'
        % Definition:
        %   Super primes are primes whose index in the ordered list of primes is itself prime.
        a=1:1:numel(pns);
        primesout=pns(isprime(a));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Super primes'};
        description={upper('Super primes'),...
            'Primes with a prime index in the prime sequence.'};

    case 'Supersingular primes'
        % Definition:
        %   Supersingular primes are the known primes dividing the order of the Monster group.
        %   This explorer uses the classical list of 15 values.
        primesout=[2 3 5 7 11 13 17 19 23 29 31 41 47 59 71];
        primesout=primesout(primesout<=t);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Supersingular primes'};
        description={upper('Supersingular primes'),...
            'Classical list of supersingular primes within range.'};

    case 'Thabit primes (3*2^n + 1)'
        % Definition:
        %   Thabit primes (plus form) are primes of the form 3*2^n + 1.
        q=0:1:floor(log2((t-1)/3));
        p=3.*2.^q+1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Thabit primes +'};
        description={upper('Thabit primes (plus)'),...
            'Primes of the form 3*2^n + 1.'};

    case 'Thabit primes (3*2^n - 1)'
        % Definition:
        %   Thabit primes (minus form) are primes of the form 3*2^n - 1.
        q=0:1:floor(log2((t+1)/3));
        p=3.*2.^q-1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Thabit primes -'};
        description={upper('Thabit primes (minus)'),...
            'Primes of the form 3*2^n - 1.'};

    case 'Twin primes'
        % Definition:
        %   Twin primes are pairs of primes (p, p+2).
        q=repmat(pns,1,2)+repmat([0 2],length(pns),1);
        p=q(sum(isprime(q),2)==2,1);
        primesout=[p p+2];
        PrimesFlag(p)=2; PrimesFlag(p+2)=3;
        txt={'Not primes','Primes','Twin primes 1st member','Twin primes 2nd member'};
        description={upper('Twin primes'),...
            'Pairs of primes separated by 2.'};

    case 'Two sided primes'
        % Definition:
        %   Two sided primes are primes that are both left truncatable and right truncatable.
        %   This explorer uses the classical finite list.
        p=[2 3 5 7 23 37 53 73 313 317 373 797 3137 3797 739397];
        primesout=p(p<=t);
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Two sided primes'};
        description={upper('Two sided primes'),...
            'Known finite list of two sided primes within range.'};

    case 'Woodall primes'
        % Definition:
        %   Woodall primes are primes of the form n*2^n - 1.
        q=1:1:floor(sqrt(log2(t+1)));
        p=q.*2.^q-1;
        primesout=p(isprime(p));
        PrimesFlag(primesout)=2;
        txt={'Not primes','Primes','Woodall primes'};
        description={upper('Woodall primes'),...
            'Primes of the form n*2^n - 1.'};

    otherwise
        % Definition:
        %   For completeness, any family not explicitly re-implemented here
        %   falls back to standard primes. This keeps the explorer robust.
        primesout=pns;
        txt={'Not primes','Primes'};
        description={upper('Prime numbers'),...
            'Fallback to standard primes.'};
end

% -------------------------------------------------------------------------
% BASIC COLOR SET
% -------------------------------------------------------------------------
colors=[1 1 1;... % white
    0 0 1;...     % blue
    1 0 0;...     % red
    0 1 0;...     % green
    1 1 0;...     % yellow
    1 0 1;...     % magenta
    0 1 1];       % cyan

% Ensure t covers the maximum highlighted prime when needed.
if ~isempty(primesout) && max(primesout(:))>t
    t=max(primesout(:));
    NN=(1:1:t)';
    PrimesFlag=zeros(size(NN));
    PrimesFlag(isprime(NN))=1;
end

% -------------------------------------------------------------------------
% PLOT CHOSEN SPIRAL
% Try to keep UI fluid for larger t by using a light background path.
% -------------------------------------------------------------------------
scrsz = get(groot,'ScreenSize');
hFig1=figure('Color',[1 1 1],'outerposition',scrsz);

switch spirals{type}

    case 'Ulam'
        % The Ulam spiral is built on a square grid.
        N=ceil(sqrt(t));
        A=flipud(spiral(N));
        [~, idx] = sort(A(:));
        [yn, xn] = ind2sub([N N], idx);

        xn = xn-xn(1);
        yn = yn(1)-yn;

        if length(xn)>t
            xn=xn(1:t);
            yn=yn(1:t);
        end

        descrspiral={'ULAM SPIRAL',...
            'The Ulam spiral is constructed by writing positive integers in a square spiral and marking primes.'};

        plot(xn,yn,'Color',[192 192 192]./256);

    case 'Sacks'
        % The Sacks spiral is an Archimedean spiral with one rotation per perfect square.
        [xs,ys]=spirale(t,'Sacks');
        plot(xs,ys,'Color',[192 192 192]./256);

        % Use sparser coordinates for labeling/natural-number markers.
        xn=xs((0:10:length(xs))+1);
        yn=ys((0:10:length(ys))+1);

        descrspiral={'SACKS SPIRAL',...
            'An Archimedean spiral where one counterclockwise rotation corresponds to each perfect square.'};

    case 'Vogel'
        % Vogel/Fermat spiral model used in phyllotaxis.
        [xs,ys]=spirale(t,'Vogel');
        plot(xs,ys,'Color',[192 192 192]./256);

        xn=xs((0:10:length(xs))+1);
        yn=ys((0:10:length(ys))+1);

        descrspiral={'VOGEL SPIRAL',...
            'A Fermat-like spiral model with a golden-angle increment.'};

    case 'Archimede'
        % Archimede spiral variant used here to emphasize base-10 rays.
        [xn,yn]=spirale(t,'Archimede');

        descrspiral={'ARCHIMEDE SPIRAL',...
            'An Archimedean spiral emphasizing base-10 rays in this explorer.'};
end

% -------------------------------------------------------------------------
% PLOT PRIMES/FLAGS
% -------------------------------------------------------------------------
M=max(PrimesFlag);

H=zeros(M+1,1);
hold on

% Adjust marker size a bit for smoother rendering on larger sets.
ms = 4;
if t>5000
    ms = 3;
elseif t>20000
    ms = 2;
end

for I=0:M
    xi = xn(PrimesFlag==I);
    yi = yn(PrimesFlag==I);
    H(I+1)=plot(xi,yi,'o',...
        'markerfacecolor',colors(I+1,:),...
        'markeredgecolor','k',...
        'markersize',ms);
end
hold off

title(sprintf('%s Spiral of Prime Numbers between 1 and %i\n',spirals{type},t),...
    'Fontsize',14,'Fontweight','bold','Color',[0 0 0])

legend(H,txt,'Location','NorthOutside','Units','pixels')
axis square
set(findobj(hFig1, 'type','axes'),'Xcolor','w','Ycolor','w')

% -------------------------------------------------------------------------
% ADD EXPLANATORY TEXT PANELS
% -------------------------------------------------------------------------
[Timg, ~] = getframe(hFig1);
xsum=sum(sum(Timg,3));
xleftedge=find(xsum<max(xsum),1,'first')-30;
if isempty(xleftedge) || xleftedge<80
    xleftedge=120; % safe fallback
end

ip=get(hFig1,'Innerposition');

ht1 = uicontrol('Style','Text',...
    'outerposition',[11 ip(4)/2+20 xleftedge 280],...
    'BackgroundColor',[0 1 1]);
set(ht1,'String',textwrap(ht1,descrspiral))

ht2 = uicontrol('Style','Text',...
    'outerposition',[11 11 xleftedge ip(4)/2-20],...
    'BackgroundColor',[0.8650 0.8110 0.4330]);
set(ht2,'String',textwrap(ht2,description))

% -------------------------------------------------------------------------
% OUTPUT
% -------------------------------------------------------------------------
if nargout
    output=primesout;
end
end

% =========================================================================
% Helper: spiral coordinate generator
% =========================================================================
function [x,y]=spirale(t,s)
% SPIRALE Compute planar coordinates for different spiral models.
% This helper is intentionally simple and fast for interactive use.

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

    otherwise
        rho=sqrt(1:0.1:t);
        theta=rho.*2*pi;
end

[x,y]=pol2cart(theta, rho);
end

% =========================================================================
% Helper: digit sum with power
% =========================================================================
function y=digitsum(num,f)
% DIGITSUM Sum of decimal digits raised to power f.
% Example:
%   digitsum(123,1) = 1+2+3
%   digitsum(123,2) = 1^2+2^2+3^2

y=0; x=num;
while x>=1
    y=y+rem(x,10)^f;
    x = floor(x / 10);
end
end
