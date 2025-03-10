covergroup coverage;


  // Coverpoints for wdata
  coverpoint fint.wdata {
    bins data_bin[] = {[0:255]}; 
  }

  // Coverpoints for rdata
  coverpoint fint.rdata {
    bins data_bin[] = {[0:255]}; 
  }

  // Coverpoints for wfull flag
  coverpoint fint.wfull {
    bins full_bin[] = {0, 1};
  }

  // Coverpoints for rempty flag
  coverpoint fint.rempty {
    bins empty_bin[] = {0, 1};
  }
  
  


endgroup



