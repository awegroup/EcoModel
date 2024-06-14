function eco_displayResults(inp, eco)
  %ECO_DISPLAYRESULTS Display economic metrics and breakdown in AWE-Eco simulation.
  %   This function visualizes economic metrics and breakdown, including cost of
  %   energy (LCoE), net present value (NPV), return on equity (RoE), profit, and
  %   others, using pie charts and text summaries.
  %
  %   Inputs:
  %   - eco: Structure containing results and metrics of the AWE-Eco simulation.

  % Figure
  figure('units', 'normalized', 'outerposition', [0 0 0.9 0.9]);

  % Plot 1: Metrics Text
  subplot(1, 4, 1); 
  hold on
  str_2_print = sprintf(['-- Metrics --\n CF = %.2f \n LCoE = %.0f EUR/MWh \n CoVE = %.0f EUR/MWh \n LRoE = %.0f EUR/MWh \n LPoE = %.0f EUR/MWh \n NPV = %.0f k EUR \n IRR = %.3f \n ICC = %.0f k EUR \n OMC = %.0f k EUR/year \n Profit = %.0f k EUR'], ...
      eco.metrics.CF, eco.metrics.LCoE, eco.metrics.CoVE, eco.metrics.LRoE, eco.metrics.LPoE, eco.metrics.NPV/1e3, eco.metrics.IRR, eco.metrics.ICC/1e3, eco.metrics.OMC/1e3, eco.metrics.Pi/1e3);
  text(0, 1, str_2_print, 'HorizontalAlignment', 'Left', 'VerticalAlignment', 'Top', 'Interpreter', 'latex', 'FontSize', 12);
  axis off
  
  % Extracting significant ICC components
  icc_perc                     = eco.metrics.icc / sum(eco.metrics.icc) * 100;
  [sorted_icc_perc, icc_order] = sort(icc_perc, 'descend');
  significant_icc_idx          = sorted_icc_perc > 2;
  list_icc                     = eco.metrics.icc_name(icc_order(significant_icc_idx));
  pp_icc                       = sorted_icc_perc(significant_icc_idx);
  
  % Plot 2: ICC Pie Chart
  subplot(1, 4, 2);
  pie(pp_icc);
  legend(list_icc, 'Location', 'southoutside', 'Interpreter', 'latex', 'FontSize', 10);
  title(['ICC = ', num2str(round(eco.metrics.ICC / 1e3)), ' k EUR'], 'Interpreter', 'latex', 'FontSize', 12);
  
  % Extracting significant OMC components
  omc_perc                     = eco.metrics.omc / sum(eco.metrics.omc) * 100;
  [sorted_omc_perc, omc_order] = sort(omc_perc, 'descend');
  significant_omc_idx          = sorted_omc_perc > 2;
  list_omc                     = eco.metrics.omc_name(omc_order(significant_omc_idx));
  pp_omc                       = sorted_omc_perc(significant_omc_idx);
  
  % Plot 3: OMC Pie Chart
  subplot(1, 4, 3);
  pie(pp_omc);
  legend(list_omc, 'Location', 'southoutside', 'Interpreter', 'latex', 'FontSize', 10);
  title(['OMC = ', num2str(round(eco.metrics.OMC / 1e3)), ' k EUR/year'], 'Interpreter', 'latex', 'FontSize', 12);
  
  % Extracting significant LCoE contributions
  LCoE_contr_perc                      = eco.metrics.LCoE_contr / sum(eco.metrics.LCoE_contr) * 100;
  [sorted_LCoE_contr_perc, LCoE_order] = sort(LCoE_contr_perc, 'descend');
  significant_lcoe_idx                 = sorted_LCoE_contr_perc > 2;
  list_lcoe                            = eco.metrics.LCoE_contr_name(LCoE_order(significant_lcoe_idx));
  pp_lcoe                              = sorted_LCoE_contr_perc(significant_lcoe_idx);
  
  % Plot 4: LCoE Pie Chart
  subplot(1, 4, 4);
  pie(pp_lcoe);
  legend(list_lcoe, 'Location', 'southoutside', 'Interpreter', 'latex', 'FontSize', 10);
  title(['LCoE = ', num2str(round(eco.metrics.LCoE)), ' EUR/MWh'], 'Interpreter', 'latex', 'FontSize', 12);
  
  % Adding overall title for the figure
  sgtitle('Economic Metrics and Breakdown', 'Interpreter', 'latex', 'FontSize', 14);
  
  % Adjusting figure properties for better visualization
  set(gcf, 'Color', 'w');
  hold off

  % Cashflow over the project
  figure()
  hold on
  grid on
  % Bar plot for cashflow
  bar(eco.metrics.cashflow ./ 1e6, 'FaceColor', [0.2 0.6 0.8]);
  % Plot payback year as a point
  if ~isempty(eco.metrics.payback_year)
      plot(eco.metrics.payback_year + 1, eco.metrics.cashflow(eco.metrics.payback_year + 1) / 1e6, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
  end
  ylabel('Million €');
  xlabel('Year');
  xticks([1:inp.business.N_y + 1]);
  xticklabels([0:inp.business.N_y]);
  title('Cashflow over the project');
  
  % Add some aesthetic improvements
  set(gca, 'FontSize', 12, 'FontWeight', 'bold');
  legend({'Cashflow', 'Payback Year'}, 'Location', 'Best');
  hold off

  % Display outputs
  disp(['LCoE = ',num2str(round(eco.metrics.LCoE)),' €/MWh'])
  disp(['CoVE = ',num2str(round(eco.metrics.CoVE)),' €/MWh'])
  disp(['LRoE = ',num2str(round(eco.metrics.LRoE)),' €/MWh'])
  disp(['LPoE = ',num2str(round(eco.metrics.LPoE)),' €/MWh'])
  disp(['NPV = ',num2str(round(eco.metrics.NPV/1e3)),' k€'])
  disp(['IRR = ',num2str(round(eco.metrics.IRR,3)*100),'%'])
  disp(['ICC = ',num2str(round(eco.metrics.ICC/1e3)),' k€'])
  disp(['Profit = ',num2str(round(eco.metrics.Pi/1e3)),' k€/year'])
end