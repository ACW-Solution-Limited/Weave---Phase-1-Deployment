xmlport 82000 "Bank Recon. HSBC"
{

    Caption = 'Bank Recon. HSBC';
    Format = VariableText;
    Direction = Import;
    TextEncoding = UTF8;
    UseRequestPage = false;
    TableSeparator = '';
    FieldSeparator = ';';
    RecordSeparator = '<CR><LF>';
    FieldDelimiter = '';



    schema
    {
        textelement(Root)
        {
            // tableelement(BankAccReconciliationHeader; "Bank Acc. Reconciliation")
            // {
            //     UseTemporary = True;
            XmlName = 'HSBC';
            //MinOccurs = Zero;
            tableelement(BankAccReconciliationLine; "Bank Acc. Reconciliation Line")
            {
                //UseTemporary = True;

                fieldelement(RelatedPartyName; BankAccReconciliationLine."Related-Party Name")
                {
                }
                textelement(AccountNo)
                {
                    trigger OnAfterAssignVariable()
                    var
                        Pos: Integer;
                        Len: Integer;
                    begin
                        IF g_firstline = false then begin
                            Pos := strpos(AccountNo, '/');
                            Len := StrLen(AccountNo) - Pos + 1;
                            AccountNo := Delstr(AccountNo, Pos, Len);
                        end;
                    end;
                }
                fieldelement(Description; BankAccReconciliationLine.Description)
                {
                }
                textelement(g_currency)
                {
                }
                textelement(g_location)
                {
                }
                textelement(g_Bic)
                {
                }
                textelement(g_IBAN)
                {
                }
                textelement(g_accountstatus)
                {
                }

                textelement(AccountType)
                {
                }
                textelement(g_closingbalance)
                {
                }
                textelement(g_closingledgerfrom)
                {
                }
                textelement(g_closingavailbalance)
                {
                }
                textelement(g_closingavailledgerfrom)
                {
                }
                textelement(g_closingledgerbalance)
                {
                }
                textelement(g_currentledgerasat)
                {
                }
                textelement(g_currentbalance)
                {
                }
                textelement(g_currentavailableasat)
                {
                }
                fieldelement(PaymentReferenceNo; BankAccReconciliationLine."Payment Reference No.")
                {
                }
                fieldelement(TransactionText; BankAccReconciliationLine."Transaction Text")
                {
                }
                fieldelement(AdditionalTransactionInfo; BankAccReconciliationLine."Additional Transaction Info")
                {
                }
                textelement(TRNType)
                {
                }
                // fieldelement(ValueDate; BankAccReconciliationLine."Value Date")
                // {
                // }
                textelement(ValueDate)
                {
                    trigger OnAfterAssignVariable()
                    var
                        day: Integer;
                        month: Integer;
                        year: integer;
                    begin
                        IF g_firstline = false then begin

                            EVALUATE(day, COPYSTR(ValueDate, 1, 2));
                            EVALUATE(month, COPYSTR(ValueDate, 4, 2));
                            EVALUATE(year, COPYSTR(ValueDate, 7, 4));

                            g_ValueDate := DMY2DATE(day, month, year);
                        end;
                    end;
                }
                textelement(CreditAmount)
                {
                    //     trigger OnBeforePassVariable()
                    // begin
                    //     g_creditamount := Item.FieldCaption("Vendor No.");
                    // end;
                }
                textelement(DebitAmount)
                {
                }
                textelement(g_balance)
                {
                }
                textelement(g_time)
                {
                }
                textelement(TransactionDate)
                {
                    trigger OnAfterAssignVariable()
                    var
                        day: Integer;
                        month: Integer;
                        year: integer;

                    begin
                        IF g_firstline = false then begin


                            EVALUATE(day, COPYSTR(TransactionDate, 1, 2));

                            EVALUATE(month, COPYSTR(TransactionDate, 4, 2));

                            EVALUATE(year, COPYSTR(TransactionDate, 7, 4));

                            g_TransactionDate := DMY2DATE(day, month, year);
                        end;
                    end;
                }
                /* fieldelement(AppliedAmount; BankAccReconciliationLine."Applied Amount")
                 {
                 }
                 fieldelement(AdditionalTransactionInfo; BankAccReconciliationLine."Additional Transaction Info")
                 {
                 }
                 fieldelement(BankAccountNo; BankAccReconciliationLine."Bank Account No.")
                 {
                 }
                 fieldelement(CheckNo; BankAccReconciliationLine."Check No.")
                 {
                 }
                 fieldelement(DocumentNo; BankAccReconciliationLine."Document No.")
                 {
                 }
                 fieldelement(StatementNo; BankAccReconciliationLine."Statement No.")
                 {
                 }
                 fieldelement(StatementType; BankAccReconciliationLine."Statement Type")
                 {
                 }
                 fieldelement(StatementAmount; BankAccReconciliationLine."Statement Amount")
                 {
                 }

                 fieldelement(TransactionDate; BankAccReconciliationLine."Transaction Date")
                 {
                 }
                 fieldelement(Type; BankAccReconciliationLine."Type")
                 {

                 }

                 fieldelement(TransactionID; BankAccReconciliationLine."Transaction ID")
                 {
                 }

                 fieldelement(StatementLineNo; BankAccReconciliationLine."Statement Line No.")
                 {
                 }*/

                trigger OnBeforeInsertRecord()
                var
                    l_debitamount: Decimal;
                    l_creditamount: Decimal;
                    l_boolean: boolean;
                    l_BankAccount: Record "Bank Account";
                    BankAccReconciliationLine2: Record "Bank Acc. Reconciliation Line";

                begin
                    BankAccReconciliationLine2.reset;
                    g_intSeq += 1;
                    g_firstline := false;

                    if g_intSeq = 1 then
                        currXMLport.skip;


                    // Message('FirstLine:%1', g_firstline);
                    // If g_firstline = true then begin
                    //     g_firstline := false;
                    //     currXMLport.skip;
                    // end;

                    BankAccReconciliationLine."Statement No." := g_Statement_No;
                    BankAccReconciliationLine."Transaction Date" := g_TransactionDate;
                    BankAccReconciliationLine."Value Date" := g_ValueDate;
                    BankAccReconciliationLine."Statement Line No." := GetlineNo();
                    BankAccReconciliationLine."Statement Type" := BankAccReconciliationLine."Statement Type"::"Bank Reconciliation";
                    BankAccReconciliationLine."Account Type" := BankAccReconciliationLine."Account Type"::"G/L Account";
                    BankAccReconciliationLine."Bank Account No." := g_Header_No;
                    l_BankAccount.reset;
                    l_BankAccount.setrange("No.", g_Header_No);
                    l_BankAccount.FindFirst();
                    BankAccReconciliationLine."Account No." := l_BankAccount."Bank Account No.";
                    BankAccReconciliationLine.Description := l_BankAccount.Name;

                    l_boolean := Evaluate(l_debitamount, DebitAmount);
                    l_boolean := Evaluate(l_creditamount, CreditAmount);
                    If l_debitamount = 0 then begin
                        BankAccReconciliationLine.validate("Statement Amount", l_creditamount);
                        BankAccReconciliationLine.validate("Applied Amount", l_creditamount);
                    end else begin
                        BankAccReconciliationLine."Statement No." := g_Statement_No;
                        BankAccReconciliationLine."Transaction Date" := g_TransactionDate;
                        BankAccReconciliationLine."Value Date" := g_ValueDate;
                        BankAccReconciliationLine."Statement Line No." := GetlineNo();
                        BankAccReconciliationLine."Statement Type" := BankAccReconciliationLine."Statement Type"::"Bank Reconciliation";
                        BankAccReconciliationLine."Account Type" := BankAccReconciliationLine."Account Type"::"G/L Account";
                        BankAccReconciliationLine."Bank Account No." := g_Header_No;

                        BankAccReconciliationLine."Account No." := l_BankAccount."Bank Account No.";
                        BankAccReconciliationLine.Description := l_BankAccount.Name;
                        l_boolean := Evaluate(l_debitamount, DebitAmount);
                        l_boolean := Evaluate(l_creditamount, CreditAmount);
                        If l_debitamount = 0 then begin
                            BankAccReconciliationLine.validate("Statement Amount", l_creditamount);
                            BankAccReconciliationLine.validate("Applied Amount", l_creditamount);
                        end else begin
                            BankAccReconciliationLine.validate("Statement Amount", l_debitamount);
                            BankAccReconciliationLine.validate("Applied Amount", l_debitamount);
                        end;
                    end;
                end;

            }

        }
    }


    //  }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreXmlPort()
    begin
        g_firstline := true;
        Clear(g_intSeq);
    end;


    procedure SetNo(p_Header_No: Code[20]; p_statement_No: Code[20])
    begin
        g_Header_No := p_Header_No;
        g_Statement_No := p_statement_No;
    end;


    procedure GetlineNo(): Integer
    var
        BankAccReconciliationLine2: Record "Bank Acc. Reconciliation Line";
    begin

        BankAccReconciliationLine2.reset;
        BankAccReconciliationLine2.setrange("Bank Account No.", g_Header_No);
        BankAccReconciliationLine2.setrange("Statement No.", g_Statement_No);
        If BankAccReconciliationLine2.Findlast then
            exit(BankAccReconciliationLine2."Statement Line No." + 10000)
        else
            exit(10000);

    end;

    var
        g_firstline: Boolean;
        g_intSeq: Integer;
        g_Header_No: Code[20];
        g_Statement_No: Code[20];
        g_TransactionDate: Date;
        g_ValueDate: Date;
}
