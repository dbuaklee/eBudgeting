-- to delete all allocationRecord 

delete bgt_fmcolumn_allocvalue;
delete bgt_fmstrgy_allocstdprice;
delete bgt_allocstdprice;
delete bgt_allocfmcolvalue;
delete bgt_requestcolumn where bgt_allocrecordstrategy_id is not null;
delete bgt_allocrec_proposalstrgy;
delete bgt_allocrecordstrategy;
delete bgt_allocationrecord;
commit;