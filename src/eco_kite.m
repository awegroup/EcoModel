function eco = eco_kite(inp,par,eco)
global eco_settings
%% Structure
switch eco_settings.wing
    case 'fixed'
        switch par.kite.structure.fixed.approach
            case 1
                
                eco.kite.structure.CAPEX = par.kite.structure.fixed.one.p_str * inp.kite.structure.m + ...
                    par.kite.structure.fixed.one.p_wet * inp.kite.structure.A;
                
            case 2
                
                eco.kite.structure.CAPEX = (1+par.kite.structure.fixed.two.f_man)*...
                    (par.kite.structure.fixed.two.p_uni  * inp.kite.structure.m_uni + ...
                    par.kite.structure.fixed.two.p_triax * inp.kite.structure.m_tri);
        end
        eco.kite.structure.OPEX = inp.kite.f_repl * eco.kite.structure.CAPEX; % Capex times replacement frequency
        
    case 'soft'
        eco.kite.structure.CAPEX = (par.kite.structure.soft.p_fabric + par.kite.structure.soft.p_bridle ) * inp.kite.structure.A;
        
        LF = trapz(inp.atm.wind_range,inp.atm.gw.*inp.system.F_t./max(inp.system.F_t));
        par.kite.structure.soft.f_repl = LF/par.kite.structure.soft.L_str;
        eco.kite.structure.OPEX = par.kite.structure.soft.f_repl * eco.kite.structure.CAPEX; % Capex times replacement frequency
        
end
%% On board generators & power electronics
switch eco_settings.power
    case 'FG'
        eco.kite.gen.CAPEX = par.kite.obgen.p * inp.system.P_rated/1e3;  % eco.cost of the eco_settings.powererator
        eco.kite.gen.OPEX = 0;
        
    case 'GG'
        eco.kite.obGen.CAPEX = par.kite.obgen.p * (inp.system.P_prop + inp.system.P_obgen)/1e3;
        eco.kite.obBatt.CAPEX = par.kite.obBatt.p * inp.system.E_batt;
        
end

%% Avionics
eco.kite.avionics.CAPEX =  par.kite.avio.C; 
eco.kite.avionics.OPEX = 0;

end