xmlport 82001 "Bank Recon. BEA"
{
    Caption = 'Bank Recon. BEA';
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
        textelement(RootNodeName)
        {
            XmlName = 'BEA';
            tableelement(BankAccReconciliationLine; "Bank Acc. Reconciliation Line")
            {
                textelement(type)
                {
                }
                textelement(ValueDate)
                {
                    trigger OnAfterAssignVariable()
                    var
                        day: Integer;
                        month: Integer;
                        year: integer;
                    begin
                        IF g_intSeq >= 11 then begin
                            EVALUATE(month, COPYSTR(ValueDate, 1, 2));
                            EVALUATE(day, COPYSTR(ValueDate, 4, 2));
                            EVALUATE(year, COPYSTR(ValueDate, 7, 4));
                            g_ValueDate := DMY2DATE(day, month, year);
                        end;
                    end;
                }
                textelement(Time)
                { }
                textelement(CurrencyCode)
                {
                }
                textelement(CreditAmount)
                { }
                textelement(DebitAmount)
                { }
                textelement(Balance)
                { }
                textelement(NoofTransaction)
                { }
                fieldelement(Description; BankAccReconciliationLine.Description)
                { }

                fieldelement(PaymentReferenceNo; BankAccReconciliationLine."Payment Reference No.")
                {
                }
                fieldelement(TransactionText; BankAccReconciliationLine."Transaction Text")
                {
                }


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
                    if (g_intSeq < 11) or (Type <> 'Transaction') then
                        currXMLport.skip;

                    BankAccReconciliationLine."Statement No." := g_Statement_No;
                    BankAccReconciliationLine."Transaction Date" := g_ValueDate;
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
                        BankAccReconciliationLine."Transaction Date" := g_ValueDate;
                        BankAccReconciliationLine."Value Date" := g_ValueDate;
                        BankAccReconciliationLine."Statement Line No." := GetlineNo();
                        BankAccReconciliationLine."Statement Type" := BankAccReconciliationLine."Statement Type"::"Bank Reconciliation";
                        BankAccReconciliationLine."Account Type" := BankAccReconciliationLine."Account Type"::"G/L Account";
                        BankAccReconciliationLine."Bank Account No." := g_Header_No;

                        BankAccReconciliationLine."Account No." := l_BankAccount."Bank Account No.";
                        BankAccReconciliationLine.Description := l_BankAccount.Name;
                        If l_debitamount = 0 then begin
                            BankAccReconciliationLine.validate("Statement Amount", l_creditamount);
                        end else begin
                            BankAccReconciliationLine.validate("Statement Amount", l_debitamount);
                        end;
                    end;
                end;

            }

        }

    }

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
        g_ValueDate: Date;
        g_intSeq: Integer;
        g_Header_No: Code[20];
        g_Statement_No: Code[20];


}
