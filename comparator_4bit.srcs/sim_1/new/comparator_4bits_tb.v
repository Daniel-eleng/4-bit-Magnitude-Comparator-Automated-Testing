`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2026 11:07:15 PM
// Design Name: 
// Module Name: comparator_4bits_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module comparator_4bits_tb;
    reg [3:0] A_tb,B_tb;
    reg eq_fisier_cpp, gt_fisier_cpp, lt_fisier_cpp;//le vom folosi pentru a citi valorile obtinute din fisierul text generat de c++
    wire eq,gt,lt;
    
    comparator_4bits TEST(.A(A_tb), .B(B_tb), .eq(eq), .gt(gt), .lt(lt));
    
    /*Deoarece am facut programul sigur in c++ si scriptul in python, ele au generat 2 fisiere text:unul cu valorile pentru citire
    si unul pentru valorile cu care vrem sa ne comparam valorile curente => avem nevoie de 4 variabile pentru fisiere: 2 pentru a 
    deschide fisiere si 2 pentru a citi din ele. De asemenea avem nevoie sa numaram cate teste bune, esuate avem, si de asemenea 
    numarul total de teste. */

    integer deschidere_fisier_cpp, deschidere_fisier_python, citire_fisier_cpp, citire_fisier_python;
    integer contor_teste, contor_teste_cu_succes, contor_teste_esuate;
    
    initial begin
        {A_tb,B_tb} = 0;

        contor_teste = 0;
        contor_teste_cu_succes = 0;
        contor_teste_esuate = 0;

        deschidere_fisier_cpp = $fopen("rezultate_asteptate.txt","r");
        deschidere_fisier_python = $fopen("intrari_test.txt","r");
        if(deschidere_fisier_cpp == 0 && deschidere_fisier_python == 0)begin
            $display("EROARE CITIRE FISIER!");
            $finish;
        end
        while(!$feof(deschidere_fisier_cpp) && !$feof(deschidere_fisier_python)) begin
            citire_fisier_cpp = $fscanf(deschidere_fisier_cpp, "%b %b %b\n",gt_fisier_cpp, lt_fisier_cpp, eq_fisier_cpp);
            citire_fisier_python = $fscanf(deschidere_fisier_python, "%b %b\n",A_tb,B_tb);
            #10;
            contor_teste = contor_teste + 1;
            if(gt === gt_fisier_cpp && lt === lt_fisier_cpp && eq === eq_fisier_cpp)begin
                contor_teste_cu_succes = contor_teste_cu_succes + 1;
            end else begin
                contor_teste_esuate = contor_teste_esuate + 1;
                $display("Testul %d a esuat! Valorile lui A si B sunt: %b | %b",contor_teste,A_tb,B_tb);
                $display("Valoarea din codul c++ este: gt: %b | eq: %b | lt: %b",gt_fisier_cpp,eq_fisier_cpp,lt_fisier_cpp);
                $display("Valoarea din codul verilog este: gt: %b | eq: %b | lt: %b",gt,eq,lt);
            end
        end

        $display("Sumare testari:");
        $display("%d Testari in total",contor_teste);
        $display("%d Testari reusite",contor_teste_cu_succes);
        $display("%d Testari esuate",contor_teste_esuate);
    end  

endmodule
