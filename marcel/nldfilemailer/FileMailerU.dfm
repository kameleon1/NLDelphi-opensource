object FileMailer: TFileMailer
  OldCreateOrder = False
  Left = 380
  Top = 225
  Height = 150
  Width = 215
  object SMTP: TIdSMTP
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 25
    AuthenticationType = atNone
    MailAgent = 'NLDFileMailer'
    HeloName = 'NLDFileMailer'
    Left = 20
    Top = 12
  end
  object MailMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    Left = 88
    Top = 12
  end
end
