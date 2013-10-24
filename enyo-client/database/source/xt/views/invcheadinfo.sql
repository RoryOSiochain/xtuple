select xt.create_view('xt.invcheadinfo', $$

select invchead.*,
  xt.invc_allocated_credit(invchead) as allocated_credit,
  xt.invc_outstanding_credit(invchead) as outstanding_credit,
  xt.invc_subtotal(invchead) as subtotal,
  xt.invc_tax_total(invchead) as tax_total,
  xt.invc_total(invchead) as total,
  GREATEST(0.0, COALESCE(xt.invc_total(invchead), 0) 
    - COALESCE(xt.invc_allocated_credit(invchead), 0)
    - COALESCE(xt.invc_outstanding_credit(invchead), 0)
    -- XXX TODO also subtract authorizedcredit
    ) as balance,
  cust_number 
  from invchead
  left join cust on cust_id = invchead_cust_id;

$$, false);

create or replace rule "_INSERT" as on insert to xt.invcheadinfo do instead

insert into invchead (
  invchead_id,
  invchead_cust_id,
  invchead_shipto_id,
  invchead_ordernumber,
  invchead_orderdate,
  invchead_posted,
  invchead_printed,
  invchead_invcnumber,
  invchead_invcdate,
  invchead_shipdate,
  invchead_ponumber,
  invchead_shipvia,
  invchead_fob,
  invchead_billto_name,
  invchead_billto_address1,
  invchead_billto_address2,
  invchead_billto_address3,
  invchead_billto_city,
  invchead_billto_state,
  invchead_billto_zipcode,
  invchead_billto_phone,
  invchead_shipto_name,
  invchead_shipto_address1,
  invchead_shipto_address2,
  invchead_shipto_address3,
  invchead_shipto_city,
  invchead_shipto_state,
  invchead_shipto_zipcode,
  invchead_shipto_phone,
  invchead_salesrep_id,
  invchead_commission,
  invchead_terms_id,
  invchead_freight,
  invchead_misc_amount,
  invchead_misc_descrip,
  invchead_misc_accnt_id,
  invchead_payment,
  invchead_paymentref,
  invchead_notes,
  invchead_billto_country,
  invchead_shipto_country,
  invchead_prj_id,
  invchead_curr_id,
  invchead_gldistdate,
  invchead_recurring,
  invchead_recurring_interval,
  invchead_recurring_type,
  invchead_recurring_until,
  invchead_recurring_invchead_id,
  invchead_shipchrg_id,
  invchead_taxzone_id,
  invchead_void,
  invchead_saletype_id,
  invchead_shipzone_id
) values (
  new.invchead_id,
  new.invchead_cust_id,
  new.invchead_shipto_id,
  new.invchead_ordernumber,
  new.invchead_orderdate,
  new.invchead_posted,
  new.invchead_printed,
  new.invchead_invcnumber,
  new.invchead_invcdate,
  new.invchead_shipdate,
  new.invchead_ponumber,
  new.invchead_shipvia,
  new.invchead_fob,
  new.invchead_billto_name,
  new.invchead_billto_address1,
  new.invchead_billto_address2,
  new.invchead_billto_address3,
  new.invchead_billto_city,
  new.invchead_billto_state,
  new.invchead_billto_zipcode,
  new.invchead_billto_phone,
  new.invchead_shipto_name,
  new.invchead_shipto_address1,
  new.invchead_shipto_address2,
  new.invchead_shipto_address3,
  new.invchead_shipto_city,
  new.invchead_shipto_state,
  new.invchead_shipto_zipcode,
  new.invchead_shipto_phone,
  new.invchead_salesrep_id,
  new.invchead_commission,
  new.invchead_terms_id,
  COALESCE(new.invchead_freight, 0),
  COALESCE(new.invchead_misc_amount, 0),
  new.invchead_misc_descrip,
  new.invchead_misc_accnt_id,
  new.invchead_payment,
  new.invchead_paymentref,
  new.invchead_notes,
  new.invchead_billto_country,
  new.invchead_shipto_country,
  new.invchead_prj_id,
  new.invchead_curr_id,
  new.invchead_gldistdate,
  COALESCE(new.invchead_recurring, false),
  new.invchead_recurring_interval,
  new.invchead_recurring_type,
  new.invchead_recurring_until,
  new.invchead_recurring_invchead_id,
  new.invchead_shipchrg_id,
  new.invchead_taxzone_id,
  new.invchead_void,
  new.invchead_saletype_id,
  new.invchead_shipzone_id
);

create or replace rule "_UPDATE" as on update to xt.invcheadinfo do instead

update invchead set
  invchead_id = new.invchead_id,
  invchead_cust_id = new.invchead_cust_id,
  invchead_shipto_id = new.invchead_shipto_id,
  invchead_ordernumber = new.invchead_ordernumber,
  invchead_orderdate = new.invchead_orderdate,
  invchead_posted = new.invchead_posted,
  invchead_printed = new.invchead_printed,
  invchead_invcnumber = new.invchead_invcnumber,
  invchead_invcdate = new.invchead_invcdate,
  invchead_shipdate = new.invchead_shipdate,
  invchead_ponumber = new.invchead_ponumber,
  invchead_shipvia = new.invchead_shipvia,
  invchead_fob = new.invchead_fob,
  invchead_billto_name = new.invchead_billto_name,
  invchead_billto_address1 = new.invchead_billto_address1,
  invchead_billto_address2 = new.invchead_billto_address2,
  invchead_billto_address3 = new.invchead_billto_address3,
  invchead_billto_city = new.invchead_billto_city,
  invchead_billto_state = new.invchead_billto_state,
  invchead_billto_zipcode = new.invchead_billto_zipcode,
  invchead_billto_phone = new.invchead_billto_phone,
  invchead_shipto_name = new.invchead_shipto_name,
  invchead_shipto_address1 = new.invchead_shipto_address1,
  invchead_shipto_address2 = new.invchead_shipto_address2,
  invchead_shipto_address3 = new.invchead_shipto_address3,
  invchead_shipto_city = new.invchead_shipto_city,
  invchead_shipto_state = new.invchead_shipto_state,
  invchead_shipto_zipcode = new.invchead_shipto_zipcode,
  invchead_shipto_phone = new.invchead_shipto_phone,
  invchead_salesrep_id = new.invchead_salesrep_id,
  invchead_commission = new.invchead_commission,
  invchead_terms_id = new.invchead_terms_id,
  invchead_freight = new.invchead_freight,
  invchead_misc_amount = new.invchead_misc_amount,
  invchead_misc_descrip = new.invchead_misc_descrip,
  invchead_misc_accnt_id = new.invchead_misc_accnt_id,
  invchead_payment = new.invchead_payment,
  invchead_paymentref = new.invchead_paymentref,
  invchead_notes = new.invchead_notes,
  invchead_billto_country = new.invchead_billto_country,
  invchead_shipto_country = new.invchead_shipto_country,
  invchead_prj_id = new.invchead_prj_id,
  invchead_curr_id = new.invchead_curr_id,
  invchead_gldistdate = new.invchead_gldistdate,
  invchead_recurring = new.invchead_recurring,
  invchead_recurring_interval = new.invchead_recurring_interval,
  invchead_recurring_type = new.invchead_recurring_type,
  invchead_recurring_until = new.invchead_recurring_until,
  invchead_recurring_invchead_id = new.invchead_recurring_invchead_id,
  invchead_shipchrg_id = new.invchead_shipchrg_id,
  invchead_taxzone_id = new.invchead_taxzone_id,
  invchead_void = new.invchead_void,
  invchead_saletype_id = new.invchead_saletype_id,
  invchead_shipzone_id = new.invchead_shipzone_id
where invchead_id = old.invchead_id;

create or replace rule "_DELETE" as on delete to xt.invcheadinfo do instead

select deleteinvoice(old.invchead_id);

