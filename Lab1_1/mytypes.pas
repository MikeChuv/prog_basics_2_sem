unit mytypes;
    
interface
    const nmax = 20;
    type 
        mas = array[1..nmax, 1..nmax] of real; 
        func = function(const x:real):real;
        mycharset = array[1..255] of char;
        myboolset = array[1..255] of boolean;
implementation
       
end.