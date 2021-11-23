CLASS /ey1/cl_pya_docs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
INTERFACES IF_AMDP_MARKER_HDB.
TYPES: BEGIN OF ls_pya,
        BUNIT   type   FC_BUNIT,
        GJAHR   type   GJAHR,
        BELNR   type BELNR_D,
        DOCLN   type DOCLN6,
        BUKRS   type BUKRS,
        PYA_YEAR  type  GJAHR,
        PYA_INTENTION type  /EY1/SAV_INTENT,
        PYA_INTENTION_CODE  type ZZ1_TAXINTENTION,
        ADJ_YEAR  type  GJAHR,
        ADJ_INTENTION type  /EY1/SAV_INTENT,
        ADJ_INTENTION_CODE  type ZZ1_TAXINTENTION,
        TRANSACTIONTYPE type ZRLDNRASSGNTTYPE,
        YEARBALANCE type DMBTR,
        LEDGER  type RLDNR,
        LOCALCURRENCY  type  WAERS,
        AMOUNTGROUPCUR type DMBTR,
        GROUPCURRENCY  type WAERS,
        GLACCOUNT  type RACCT,
        KTOPL type  KTOPL,
        RVERS  type FC_RVERS,
        RITCLG type FC_ITCLG,
        PeriodTo TYPE /EY1/TO_PERIOD,
     END OF ls_pya.

 DATA: lt_pya type table of ls_pya.

CLASS-METHODS: GET_DOCUMENTS
    IMPORTING
       value(iv_gjahr) TYPE gjahr
       value(iv_taxintention) TYPE zz1_taxintention
       value(iv_bunit) TYPE fc_bunit
    EXPORTING
       VALUE(et_pya) LIKE lt_pya.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS /ey1/cl_pya_docs IMPLEMENTATION.

  METHOD get_documents BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS
   READ-ONLY  USING
   ACDOCU
   /EY1/RECONLEDGER
   /EY1/TRANS_TYPE
   /EY1/SAV_i_Get_Cnsldtn_Version
   /EY1/FISCL_INTNT
   /EY1/INTENTION.

--Variable Declaration
    DECLARE lv_i             integer;
    DECLARE lv_j             integer;
    DECLARE lv_k             integer;
    DECLARE lv_from          integer;
    DECLARE lv_to            integer;
    DECLARE lv_chk_q123      CHAR DEFAULT ' ';
    DECLARE lv_count         integer;
    DECLARE lv_row           integer;
    DECLARE lv_iter          integer DEFAULT 1;
    DECLARE lv_year          "$ABAP.type( GJAHR )";
    DECLARE lv_pr_year       "$ABAP.type( GJAHR )";
    DECLARE lv_new_pr_year   "$ABAP.type( GJAHR )";
    DECLARE lv_glb_intn      "$ABAP.type( /EY1/SAv_iNTENT )";
    DECLARE lv_glb_seqnr     "$ABAP.type( SEQNR_FLB )";
    DECLARE lv_lcl_intn      "$ABAP.type( /EY1/SAv_iNTENT )";
    DECLARE lv_lcl_seqnr     "$ABAP.type( SEQNR_FLB )";
    DECLARE lv_pr_periodto   "$ABAP.type( /EY1/TO_PERIOD )";
    DECLARE lv_int_from      integer;
    DECLARE lv_int_to        integer;
    DECLARE lv_chk_cnt       integer;
    DECLARE lv_per_found     integer DEFAULT 0;

    DECLARE lt_return       TABLE (
                                    ChartOfAccounts              "$ABAP.type( KTOPL )",
                                    ConsolidationUnit            "$ABAP.type( FC_BUNIT )",
                                    ConsolidationChartOfAccounts "$ABAP.type( KTOPL )",
                                    GLAccount                    "$ABAP.type( RACCT )",
                                    FiscalYear                   "$ABAP.type( GJAHR )",
                                    belnr                        "$ABAP.type( BELNR_D )",
                                    bukrs                        "$ABAP.type( BUKRS )",
                                    YearBalance                  "$ABAP.type( DMBTR )",
                                    AmountGroupCur               "$ABAP.type( DMBTR )",
                                    TransactionType              "$ABAP.type( ZRLDNRASSGNTTYPE  )",
                                    LocalCurrency                "$ABAP.type( WAERS )",
                                    GroupCurrency                "$ABAP.type( WAERS )",
                                    ConsolidationLedger          "$ABAP.type( RLDNR )",
                                    RVERS                        "$ABAP.type( FC_RVERS )",
                                    ADJ_YEAR                     "$ABAP.type( GJAHR )",
                                    ADJ_INTENTION                "$ABAP.type( /EY1/SAv_iNTENT  )",
                                    ADJ_INTENTION_CODE           "$ABAP.type( ZZ1_TAXINTENTION )",
                                    PYA_INTENTION                "$ABAP.type( /EY1/SAv_iNTENT  )",
                                    PYA_INTENTION_CODE           "$ABAP.type( ZZ1_TAXINTENTION )",
                                    PYA_YEAR                     "$ABAP.type( GJAHR )",
                                    PeriodTo                     "$ABAP.type( /EY1/TO_PERIOD )"
                                 );

--Default Row ( This row will be deleted at line 440)
lt_return = select
                    '' AS ChartOfAccounts,
                    '' AS ConsolidationUnit,
                    '' AS ConsolidationChartOfAccounts,
                    '' AS GLAccount,
                    '' AS FiscalYear,
                    '' AS belnr,
                    '' AS bukrs,
                    0.00 AS YearBalance,
                    0.00 AS AmountGroupCur,
                    '' AS TransactionType,
                    '' AS LocalCurrency,
                    '' AS GroupCurrency,
                    '' AS ConsolidationLedger,
                    '' AS rvers,
                    '' AS ADJ_YEAR,
                    '' AS ADJ_INTENTION,
                    '' AS ADJ_INTENTION_CODE,
                    '' AS PYA_INTENTION,
                    '' as PYA_INTENTION_CODE,
                    '' AS PYA_YEAR,
                    '' AS PeriodTo
                    FROM dummy;


-- Total Intentions
lt_ttl_intent = select distinct intent, seqnr_flb from "/EY1/INTENTION"
                    ORDER BY seqnr_flb ASC;

-- Total Intentions with Row Number Column
lt_intent = select ROW_NUMBER ( ) OVER ( ORDER by seqnr_flb ) as row, intent, seqnr_flb
                from :lt_ttl_intent ORDER BY seqnr_flb ASC;

-- Total Open Years
lt_open_ryear = select distinct gjahr  from "/EY1/FISCL_INTNT"
                where mandt = SESSION_CONTEXT( 'CLIENT' )
                order by gjahr ASC;

-- Total Open Years with Row Number Column
lt_year = select ROW_NUMBER ( ) OVER ( ORDER by gjahr) as row,gjahr
                from :lt_open_ryear;

--Get Ledger Config
lt_ledger = select * from "/EY1/RECONLEDGER" where bunit = :iv_bunit
                                             and mandt = SESSION_CONTEXT( 'CLIENT' );

--Get Transaction Type
lt_transactiontype = select DISTINCT trtyp, rldnrassgnttype from "/EY1/TRANS_TYPE";

--Fetch Data from ACDOCU
lt_data = select
       ktopl    as ChartOfAccounts,
       rbunit   as ConsolidationUnit,
       ritclg   as ConsolidationChartOfAccounts,
       racct    as GLAccount,
       ryear    as FiscalYear,
       docnr    as belnr,
       robukrs  as bukrs,
       sum(hsl) as YearBalance,
       sum(KSL) as AmountGroupCur,
       TransType.rldnrassgnttype as TransactionType,
       rhcur    as LocalCurrency,
       rkcur    as GroupCurrency,
       rvers,
       GetVersion.ConsolidationLedger,
       zz1_taxintention_cje as TaxIntention
 from acdocu    as acdocu
    inner join  :lt_ledger  as ReconLedger on acdocu.rbunit = ReconLedger.bunit
                                           and ( acdocu.rldnr = ReconLedger.g2s
                                                 or
                                                 acdocu.rldnr = ReconLedger.s2t
                                               )
    inner join   :lt_transactiontype              as TransType   on  acdocu.rmvct   = TransType.trtyp
    inner join   "/EY1/SAV_I_GET_CNSLDTN_VERSION" as GetVersion  on(
       (
         GetVersion.ConsolidationLedger = ReconLedger.g2s
         and acdocu.rvers               = GetVersion.ConsolidationVersion
       )
       or(
         GetVersion.ConsolidationLedger = ReconLedger.s2t
         and acdocu.rvers               = GetVersion.ConsolidationVersion
       )
     )
 where    poper != '000'
  and     ryear                =  :iv_gjahr
  and(
          acdocu.rldnr         =  ReconLedger.g2s
    or(
          acdocu.rldnr         =  ReconLedger.s2t
      and zz1_ledgergroup_cje != 'G2S'
    )
  )
  and(
          zz1_taxintention_cje = :iv_taxintention
          --and zz1_taxintention_cje !=  ''
          --and zz1_taxintention_cje >=  '101'
  )
  and     rbunit = :iv_bunit
  group by
  ktopl,
  rbunit,
  ritclg,
  racct,
  ryear,
  rhcur,
  rkcur,
  TransType.rldnrassgnttype,
  docnr,
  rvers,
  robukrs,
  GetVersion.ConsolidationLedger,
  zz1_taxintention_cje;



  --Add Column Row ( This will be needed for further processing)
  lt_process_data =
  SELECT
    ROW_NUMBER ( ) OVER ( order by
      ChartOfAccounts,
      ConsolidationUnit ,
      ConsolidationChartOfAccounts,
      GLAccount,
      FiscalYear,
      LocalCurrency,
      GroupCurrency,
      TransactionType,
      belnr,
      bukrs,
      rvers,
      ConsolidationLedger,
      TaxIntention ) as row,
    ChartOfAccounts,
    ConsolidationUnit,
    ConsolidationChartOfAccounts,
    GLAccount,
    FiscalYear,
    belnr,
    bukrs,
    YearBalance,
    AmountGroupCur,
    TransactionType,
    rvers,
    LocalCurrency,
    GroupCurrency,
    ConsolidationLedger,
    TaxIntention
    from :lt_data;


  --Total Number of Lines in LT_DATA - This will be required in looping over all the line items coming in LT_DATA
  select count( * ) into lv_count from :lt_data;


  --Till which row we have to process ( The LT_YEAR is sequnce of all open Years ) & iv_gjahr is the Year/Intention we are closing
  --select row into lv_to from :lt_year where gjahr = :iv_gjahr;
  select count( * ) INTO lv_to from :lt_year;

  --To create lines for each item in LT_PROCESS_DATA, loop over each line item
  for lv_i in 1..lv_count do

    -- Get Fiscal Year of each row
    select FiscalYear into lv_year from :lt_process_data where row = :lv_i;

    --Assign From Year to variable lv_from
    select row into lv_from from :lt_year where gjahr = :lv_year;

    --Fetch Intention of the processing line item
    Select intent into lv_glb_intn from "/EY1/INTENTION" where taxintention =
    ( select TaxIntention from :lt_process_data WHERE row = :lv_i );

    --Fetch SEQNR of lv_glb_intn ( processing line item Intention )
    SELECT seqnr_flb INTO lv_glb_seqnr FROM :lt_intent where intent = :lv_glb_intn;

    --Assign the last intention to consider in lv_iNT_TO
    select row INTO lv_int_to from :lt_intent WHERE intent = :lv_glb_intn;

    --from pervious year( max ) to current year
    for lv_j in :lv_from..lv_to do

        -- Get Year For Fetching Open Intention
        select gjahr into lv_pr_year from :lt_year where row = :lv_j;

        --Change Global Intention for Subsequent Years
        IF :lv_j = :lv_from THEN
        ELSE

          --Logic to change the Global Intention
          SELECT gjahr INTO lv_new_pr_year FROM :lt_year WHERE row = ( :lv_j - :lv_iter );

          --Check from PYA table if entry considered for any intention
          lt_check = SELECT * from :lt_return WHERE pya_year = :lv_new_pr_year
                                   AND   belnr = ( select belnr from :lt_process_data WHERE row = :lv_i )
                                   AND   FiscalYear = ( select FiscalYear from :lt_process_data WHERE row = :lv_i  )
                                   AND   YearBalance = ( select YearBalance from :lt_process_data WHERE row = :lv_i  );

          SELECT count( * ) INTO lv_chk_cnt FROM :lt_check;

          IF :lv_chk_cnt > 0 THEN
              --Get the Open Intention of new Year
              lt_intn = select * from "/EY1/FISCL_INTNT" where
                     gjahr = :lv_new_pr_year
                     AND bunit = ( select ConsolidationUnit from :lt_process_data where row = :lv_i );


              Select INTENTION into lv_glb_intn from :lt_intn WHERE bunit =
                    ( select ConsolidationUnit from :lt_process_data where row = :lv_i  )
                    AND gjahr = :lv_new_pr_year;

              --Fetch SEQNR of lv_glb_intn ( processing line item Intention )
              SELECT seqnr_flb INTO lv_glb_seqnr FROM :lt_intent where intent = :lv_glb_intn;
          ELSE
              --lv_iter = :lv_iter - 1;
          END IF;
         END IF;

        --Process the Year only if it is less than the Input Parameter Year
        --IF :lv_pr_year < :iv_gjahr --AND :lv_pr_year <> :lv_year
        --THEN

        -- Get Intention Staus of processing year ( This is the open intention for the year processing )
        lt_intention = select * from "/EY1/FISCL_INTNT" where
                 gjahr = :lv_pr_year
                 AND bunit = ( select ConsolidationUnit from :lt_process_data where row = :lv_i );

        IF ( select count( * ) from :lt_intention ) > 0 THEN
        --Fetch Intention of the OPEN intention for current processing year
         SELECT intention into lv_lcl_intn from :lt_intention;
        ELSE
         CONTINUE;
        END IF;

        --Fetch SEQNR for OPEN intention
        SELECT seqnr_flb INTO lv_lcl_seqnr FROM :lt_intent where intent = :lv_lcl_intn;

        select row INTO lv_int_from from :lt_intent WHERE intent = :lv_lcl_intn;

        --Since I am processing Open Year( IV_GJAHR ) and Open Intention ( IV_TAXINTENTION )
        -- It should check all docs for previous year posted in Intention less than processing doc intention

        IF :lv_lcl_seqnr < :lv_glb_seqnr AND :lv_pr_year > :lv_year
        THEN

                --Clear lv_per_found --> Clear PER Intention Found Check Variable by assining 0 to it.
                lv_per_found = 0;

                --Create Line Items for each intention for the year
                FOR lv_k IN :lv_int_from..lv_int_to do

                    select intent INTO lv_lcl_intn from :lt_intent WHERE row = :lv_k;

                    SELECT seqnr_flb INTO lv_lcl_seqnr from :lt_intent where intent = :lv_lcl_intn;

                    IF lv_per_found = 1 THEN
                     -- Check the Period To Value, if it is greater than the processing intention, skip the intention
                        IF lv_pr_periodto > ( SELECT periodto from "/EY1/INTENTION" where intent = :lv_lcl_intn ) THEN
                            CONTINUE ;
                        END IF;
                    END IF ;

                    --Do not cosider where both the intentions are same
                    IF (   :lv_lcl_intn <> :lv_glb_intn
                        AND :lv_lcl_seqnr < :lv_glb_seqnr ) THEN


                        --Special Handling of Intention "PER"
                        IF :lv_lcl_intn = 'PER' THEN
                           lv_per_found = 1;
                           SELECT period_to into lv_pr_periodto from :lt_intention where gjahr = :lv_pr_year AND intention = 'PER';
                        END IF ;

                        -- The entry should only be inserted in open intention ( and the yet to open comparing the intention of previous year)
                        --Creating the line with PYA Year, PYA Intention and Processing Year, Processing Intention
                        lt_ret_data = select
                                        ChartOfAccounts,
                                        ConsolidationUnit,
                                        ConsolidationChartOfAccounts,
                                        GLAccount,
                                        FiscalYear,
                                        belnr,
                                        bukrs,
                                        YearBalance,
                                        AmountGroupCur,
                                        TransactionType,
                                        LocalCurrency,
                                        GroupCurrency,
                                        ConsolidationLedger,
                                        rvers,
                                        FiscalYear               AS ADJ_YEAR,
                                        b.Intent                 AS ADJ_INTENTION,
                                        b.taxintention           AS ADJ_INTENTION_CODE,
                                        :lv_lcl_intn              AS PYA_INTENTION,
                                        '' AS PYA_INTENTION_CODE,
                                        :lv_pr_year               AS PYA_YEAR,
                                        CASE WHEN :lv_lcl_intn = 'PER' THEN
                                         lv_pr_periodto
                                        ELSE
                                         ( SELECT periodto from "/EY1/INTENTION" where intent = :lv_lcl_intn )
                                        END as PeriodTo
                                        from :lt_process_data AS a
                                        inner join "/EY1/INTENTION" AS b
                                        ON a.TaxIntention = b.TaxIntention
                                        WHERE row = :lv_i;

                        --Appending data to LT_RETURN table
                        lt_return = SELECT * from :lt_return
                                       UNION ALL
                                    SELECT * FROM :lt_ret_data;

                        IF :lv_lcl_intn = 'Q1' OR
                           :lv_lcl_intn = 'Q2' OR
                           :lv_lcl_intn = 'Q3' OR
                           :lv_lcl_intn = 'TXP' THEN
                          lv_chk_q123  = 'X';
                        END IF;
                    END IF;
                END FOR ;

                IF :lv_chk_q123 = 'X' THEN
                 lv_chk_q123 = ' ';
                 --change lv_j of year to last ( lv_to )
                 lv_j = :lv_to;
                END IF ;

            ELSE
                --Do Nothing
            END IF;
        --END IF;
    END FOR ;
  END FOR ;

  --LT_RETURN will have the data
  --This is to remove the blank line item we added to create table LT_RETURN
  lt_return = select * from :lt_return where YearBalance <> 0.00;


  lt_pya = select
                PYA_YEAR,
                PYA_INTENTION,
                b.taxintention AS PYA_INTENTION_CODE,
                ADJ_YEAR,
                ADJ_INTENTION,
                ADJ_INTENTION_CODE,
                TransactionType,
                YearBalance,
                AmountGroupCur,
                LocalCurrency,
                GroupCurrency,
                GLAccount,
                ChartOfAccounts as KTOPL,
                ConsolidationLedger as LEDGER,
                ConsolidationUnit as bunit,
                bukrs,
                belnr,
                FiscalYear as gjahr,
                rvers,
                ConsolidationChartOfAccounts AS RITCLG,
                a.PeriodTo as PeriodTo
                from :lt_return AS a
                INNER JOIN "/EY1/INTENTION" AS b
                ON a.pya_intention = b.intent;

    lt_pya1 = select BUNIT,
                    GJAHR,
                    BELNR,
                    ROW_NUMBER ( ) OVER ( PARTITION BY bunit,gjahr, belnr, bukrs ORDER BY bunit,gjahr, belnr, bukrs ) as DOCLN,
                    BUKRS,
                    PYA_YEAR,
                    PYA_INTENTION,
                    PYA_INTENTION_CODE,
                    ADJ_YEAR,
                    ADJ_INTENTION,
                    ADJ_INTENTION_CODE,
                    TRANSACTIONTYPE,
                    YEARBALANCE,
                    LEDGER,
                    LOCALCURRENCY,
                    AMOUNTGROUPCUR,
                    GROUPCURRENCY,
                    GLACCOUNT,
                    KTOPL,
                    RVERS,
                    RITCLG,
                    PeriodTo
                    from :lt_pya;

     -- Documents posted in "TXP" not to be considered for PYA
     et_pya = select BUNIT,
                    GJAHR,
                    BELNR,
                    DOCLN,
                    BUKRS,
                    PYA_YEAR,
                    PYA_INTENTION,
                    PYA_INTENTION_CODE,
                    ADJ_YEAR,
                    ADJ_INTENTION,
                    ADJ_INTENTION_CODE,
                    TRANSACTIONTYPE,
                    YEARBALANCE,
                    LEDGER,
                    LOCALCURRENCY,
                    AMOUNTGROUPCUR,
                    GROUPCURRENCY,
                    GLACCOUNT,
                    KTOPL,
                    RVERS,
                    RITCLG,
                    PERIODTO
                    from :lt_pya1
                    where adj_intention <> 'TXP';
  ENDMETHOD.

ENDCLASS.
