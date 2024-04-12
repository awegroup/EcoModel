function inp = eco_inputs

global eco_settings

if strcmp(eco_settings.input_model_file,'code')
       
    % Topology specific caractheristics
    
    if strcmp(eco_settings.power,'FG')
      
        % Wind resources
        inp.atm.wind_range = [4,5,6,7,8,9,10,11,12,13,14,16,18,20,22];
        atm.k = 2;
        atm.A = 8;
        inp.atm.gw = atm.k/atm.A *(inp.atm.wind_range/atm.A).^(atm.k-1).*exp(-(inp.atm.wind_range/atm.A).^atm.k); % Wind distribution
        
        % Business related quantities
        inp.business.T = 25; % years
        inp.business.r = 0.1; % discount rate

        % Power and loads
        inp.system.F_t = [19581.5974490300,30589.4427976802,43855.1311512270,58322.4490072310,69451.8065536476,68432.4018007148,69371.4628861828,69478.8976127206,69485.8563217407,69497.1308164078,69482.9452160423,69481.7762790974,69481.0428798217,62833.9833242605,51867.1740101547];
        inp.system.P = [21496.0471473482,41246.4942079856,69966.0193058485,108887.503260755,156932.246230542,198576.031463368,198565.375606173,198114.942308234,197641.383532483,197199.181237688,196755.860610617,195920.800890573,195135.252500918,174603.698597567,143719.204086628];
        inp.system.P_rated = 200e3;
        
        inp.kite.structure.m = 4e2;
        inp.kite.structure.A = 15;
        inp.kite.f_repl = 0;
        
        inp.tether.d = 2e-2;
        inp.tether.sigma_lim = 1.5e9;
        inp.tether.L = 300;
        inp.tether.rho = 1e3;
        
    elseif  strcmp(eco_settings.power,'GG')

        if strcmp(eco_settings.wing,'fixed')

          % Wind resources
          inp.atm.wind_range = [1:1:25];
          atm.k = 2;
          atm.A = 10;
          inp.atm.gw = atm.k/atm.A *(inp.atm.wind_range/atm.A).^(atm.k-1).*exp(-(inp.atm.wind_range/atm.A).^atm.k); % Wind distribution
          
          % Business related quantities
          inp.business.T = 25; % years
          inp.business.r = 0.1; % discount rate
          
          % Power and loads
          inp.system.F_t = [0	0	0	0	182818.959316332	295408.178060434	419690.246978853	450000.000015734	449992.160039458	450000.000000000	450000.000000253	450000.000000000	449999.680709179	442573.874551799	438814.591609086	429597.887168394	429257.929939298	422567.939253649	419685.418715207	417373.577072876	415928.968598799	414967.739557817	414273.382259127	413748.643654778	413343.209219202];
          inp.system.P_out_rated = 4.0000e+06;
          inp.system.P = [0	0	0	0	87438.8853031594	253393.205748841	484332.048240857	755090.545996486	1114076.64124289	1405930.79083093	1670466.98327117	1903559.07568152	1999999.99857249	1999999.94760103	2000000.00000002	2000000.00000006	2000000.00106575	1999999.43299789	2000000.00027475	2000000.08302597	2000000.00296865	2000000.00016184	2000000.00002195	2000000.00001266	2000000.00000112];
          inp.system.P_rated = 2000*1000;
          
          inp.system.E_rated_uc = 1.5*inp.system.P_rated * 60/3600; 
          %inp.system.f_repl_uc = 0.25;
          inp.system.E_ex_uc = inp.system.E_rated_uc/2; % check
          inp.system.Dt_cycle = 80/3600; % h
          
          inp.system.E_ex_hacc = inp.system.E_rated_uc;

          inp.kite.structure.m = 9.250207476900000e+03;
          inp.kite.structure.A = 150;
          
          inp.kite.f_repl = 0;
          
          inp.tether.d = 0.030901936161855;
          inp.tether.sigma_lim = 1.5e9;
          inp.tether.L = 2.000004520590911e+03;
          inp.tether.rho = 970;
          
          inp.system.P_obgen = 1e3;
          inp.system.P_prop = 1e3;
          inp.system.E_batt = 0;

        elseif strcmp(eco_settings.wing,'soft')
            
          % Wind resources
          inp.atm.wind_range = [4,5,6,7,8,9,10,11,12,13,14,16,18,20,22];
          atm.k = 2;
          atm.A = 8;
          inp.atm.gw = atm.k/atm.A *(inp.atm.wind_range/atm.A).^(atm.k-1).*exp(-(inp.atm.wind_range/atm.A).^atm.k); % Wind distribution
          
          % Business related quantities
          inp.business.T = 25; % years
          inp.business.r = 0.1; % discount rate
          
          % Power and loads
          inp.system.F_t = [19581.5974490300,30589.4427976802,43855.1311512270,58322.4490072310,69451.8065536476,68432.4018007148,69371.4628861828,69478.8976127206,69485.8563217407,69497.1308164078,69482.9452160423,69481.7762790974,69481.0428798217,62833.9833242605,51867.1740101547];
  %         inp.system.P_out = [21496.0471473482,41246.4942079856,69966.0193058485,108887.503260755,156932.246230542,198576.031463368,198565.375606173,198114.942308234,197641.383532483,197199.181237688,196755.860610617,195920.800890573,195135.252500918,174603.698597567,143719.204086628];
          inp.system.P_out_rated = 200e3;
          inp.system.P = 3/4*[21496.0471473482,41246.4942079856,69966.0193058485,108887.503260755,156932.246230542,198576.031463368,198565.375606173,198114.942308234,197641.383532483,197199.181237688,196755.860610617,195920.800890573,195135.252500918,174603.698597567,143719.204086628];
          inp.system.P_rated = max(inp.system.P);
          
          inp.system.E_rated_uc = 1.5*inp.system.P_rated * 40/3600; 
          inp.system.f_repl_uc = 0.25;
          inp.system.E_ex_uc = inp.system.E_rated_uc/2; % check
          inp.system.Dt_cycle = 60/3600; % h
          
          inp.system.E_ex_hacc = inp.system.E_rated_uc;

          inp.kite.structure.m = 4e2;
          inp.kite.structure.A = 15;
          
          inp.kite.f_repl = 0;
          
          inp.tether.d = 2e-2;
          inp.tether.sigma_lim = 1.5e9;
          inp.tether.L = 300;
          inp.tether.rho = 1e3;
          
          inp.system.P_obgen = 1e3;
          inp.system.P_prop = 1e3;
          inp.system.E_batt = 0;

          inp.kite.structure.A = 15;
          
          inp.tether.d = 2e-2;
          inp.tether.sigma_lim = 1.5e9;
          inp.tether.L = 300;
          inp.tether.rho = 1e3;
          
          inp.system.P_obgen = 1e3;
          inp.system.P_prop = 0;
          inp.system.E_batt = 0;
            
        end
        
    end
    
else
    inp = eco_import_model;
    
end

end