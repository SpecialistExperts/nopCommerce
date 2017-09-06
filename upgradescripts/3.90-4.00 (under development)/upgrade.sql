﻿--upgrade scripts from nopCommerce 3.90 to 4.00

--new locale resources
declare @resources xml
--a resource will be deleted if its value is empty
set @resources='
<Language>
  <LocaleResource Name="Admin.System.SystemInfo.ServerVariables">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.System.SystemInfo.ServerVariables.Hint">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.System.SystemInfo.Headers">
    <Value>Headers</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.System.SystemInfo.Headers.Hint">
    <Value>A list of headers.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.System.Warnings.MachineKey.NotSpecified">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.System.Warnings.MachineKey.Specified">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Account.AssociatedExternalAuth.YourAccountWillBeLinkedTo.Remove">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Account.AssociatedExternalAuth.YourAccountWillBeLinkedTo">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.CustomerUser.ExternalAuthenticationAutoRegisterEnabled">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.CustomerUser.ExternalAuthenticationAutoRegisterEnabled.Hint">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.CustomerUser.BlockTitle.ExternalAuthentication">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Plugins.OfficialFeed.Instructions">
    <Value><![CDATA[<p>Here you can find third-party extensions and themes which are developed by our community and partners.They are also available in our <a href="https://www.nopcommerce.com/marketplace.aspx?utm_source=admin-panel&utm_medium=official-plugins&utm_campaign=admin-panel" target="_blank">marketplace</a></p>]]></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Stores.Fields.SecureUrl.Hint">
    <Value>The secure URL of your store e.g. https://www.yourstore.com/ or http://sharedssl.yourstore.com/. Leave it empty if you want nopCommerce to detect secure URL automatically.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.GeneralCommon.Captcha.Instructions">
    <Value><![CDATA[<p>CAPTCHA is a program that can tell whether its user is a human or a computer. You''ve probably seen them — colorful images with distorted text at the bottom ofWeb registration forms. CAPTCHAs are used by many websites to prevent abuse from "bots" or automated programs usually written to generate spam. No computer programcan read distorted text as well as humans can, so bots cannot navigate sites protectedby CAPTCHAs. nopCommerce uses <a href="http://www.google.com/recaptcha" target="_blank">reCAPTCHA</a>.</p>]]></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.ContentManagement.MessageTemplates.Description.Customer.EmailValidationMessage">
	  <Value>This message template is used when Configuration - Settings - Customer settings - "Registration method" dropdownlist is set to "Email validation". The customer receives a message to confirm an email address used when registering.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.Media.CategoryThumbPictureSize.Hint">
    <Value>The default size (pixels) for category thumbnail images.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.Media.ManufacturerThumbPictureSize.Hint">
    <Value>The default size (pixels) for manufacturer thumbnail images.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Customers.OnlineCustomers.Fields.IPAddress.Disabled">
    <Value>"Store IP addresses" setting is disabled</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.CustomerUser.StoreIpAddresses">
    <Value>Store IP addresses</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.CustomerUser.StoreIpAddresses.Hint">
    <Value>When enabled, IP addresses of customers will be stored. When disabled, it can improved performance. Furthermore, it''s prohibited to store IP addresses in some countries (private customer data).</Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.AddressOverride">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.AddressOverride.Hint">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.EnableIpn">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.EnableIpn.Hint">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.EnableIpn.Hint2">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.IpnUrl">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.IpnUrl.Hint">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.PDTValidateOrderTotal">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.PDTValidateOrderTotal.Hint">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.ReturnFromPayPalWithoutPaymentRedirectsToOrderDetailsPage">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Fields.ReturnFromPayPalWithoutPaymentRedirectsToOrderDetailsPage.Hint">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalStandard.Instructions">
    <Value><![CDATA[<p><b>If you''re using this gateway ensure that your primary store currency is supported by Paypal.</b><br /><br />To use PDT, you must activate PDT and Auto Return in your PayPal account profile. You must also acquire a PDT identity token, which is used in all PDT communication you send to PayPal. Follow these steps to configure your account for PDT:<br /><br />1. Log in to your PayPal account (click <a href="https://www.paypal.com/us/webapps/mpp/referral/paypal-business-account2?partner_id=9JJPJNNPQ7PZ8" target="_blank">here</a> to create your account).<br />2. Click the Profile subtab.<br />3. Click Website Payment Preferences in the Seller Preferences column.<br />4. Under Auto Return for Website Payments, click the On radio button.<br />5. For the Return URL, enter the URL on your site that will receive the transaction ID posted by PayPal after a customer payment ({0}).<br />6. Under Payment Data Transfer, click the On radio button.<br />7. Click Save.<br />8. Click Website Payment Preferences in the Seller Preferences column.<br />9. Scroll down to the Payment Data Transfer section of the page to view your PDT identity token.<br /><br /></p>]]></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.GeneralCommon.EnableCssBundling.Hint">
    <Value>Enable to combine (bundle) multiple CSS files into a single file. Do not enable if you''re running nopCommerce in IIS virtual directory. Currently it doesn''t support web farms.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.GeneralCommon.EnableJsBundling.Hint">
    <Value>Enable to combine (bundle) multiple JavaScript files into a single file. Currently it doesn''t support web farms.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.Vendor.TermsOfServiceEnabled">
    <Value>Terms of service</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.Vendor.TermsOfServiceEnabled.Hint">
    <Value>Require vendors to accept terms of service during registration.</Value>
  </LocaleResource>
  <LocaleResource Name="Vendors.ApplyAccount.AcceptTermsOfService">
    <Value>I accept terms of service</Value>
  </LocaleResource>
  <LocaleResource Name="Vendors.ApplyAccount.AcceptTermsOfService.Read">
    <Value>(read)</Value>
  </LocaleResource>
  <LocaleResource Name="Vendors.ApplyAccount.AcceptTermsOfService.Required">
    <Value>Please accept terms of service</Value>
  </LocaleResource>
  <LocaleResource Name="Payment.ExpirationDate.Expired">
    <Value>Card is expired</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.GeneralCommon.PopupForTermsOfServiceLinks">
    <Value>Popup windows for "terms of service"</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.GeneralCommon.PopupForTermsOfServiceLinks.Hint">
    <Value>Check if you want "accept terms of service" or "accept privacy policy" links to be open in popup window. If disabled, then they''ll be open on a new page.</Value>
  </LocaleResource>
  <LocaleResource Name="ActivityLog.DeleteSystemLog">
    <Value>Deleted system log</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.Order.AllowAdminsToBuyCallForPriceProducts">
    <Value>Allow admins to buy "Call for price" products</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.Order.AllowAdminsToBuyCallForPriceProducts.Hint">
    <Value>Check to allow administrators (in impersonation mode) are allowed to buy products marked as "Call for price".</Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Shipping.CanadaPost.Fields.Services">
    <Value>Available services</Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Shipping.CanadaPost.Fields.Services.Hint">
    <Value>Select the services you want to offer to customers.</Value>
  </LocaleResource>
  <LocaleResource Name="Account.AssociatedExternalAuth.EmailAlreadyExists">
    <Value>A user with the specified email has been already registered. If this is your account, and you want to associate it with ''{0}'' external record, please login firstly.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Customers.CustomerRoles.Fields.OverrideTaxDisplayType">
    <Value>Overrride default tax display type</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Customers.CustomerRoles.Fields.OverrideTaxDisplayType.Hint">
    <Value>Check to override the default tax display type.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Customers.CustomerRoles.Fields.DefaultTaxDisplayType">
    <Value>Default tax display type</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Customers.CustomerRoles.Fields.DefaultTaxDisplayType.Hint">
    <Value>Default tax display type.</Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Pickup.PickupInStore.Fields.DisplayOrder">
    <Value>Display order</Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Pickup.PickupInStore.Fields.DisplayOrder.Hint">
    <Value>Specify the pickup point display order.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.AddNew">
    <Value>Add a new attribute</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.EditAttributeDetails">
    <Value>Edit product attribute</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.BackToProduct">
    <Value>back to product details</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Values.BackToProduct">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Info">
    <Value>Info</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Values.SaveBeforeEdit">
    <Value>You need to save the product attribute before you can add values for this product attribute page.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Fields.Attribute.Hint">
    <Value>Choose an attribute.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Fields.AttributeControlType.Hint">
    <Value>Choose how to display your attribute values.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Fields.DisplayOrder.Hint">
    <Value>The attribute display order. 1 represents the first item in the list.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Fields.IsRequired.Hint">
    <Value>When an attribute is required, the customer must choose an appropriate attribute value before they can continue.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Fields.TextPrompt.Hint">
    <Value>Enter text prompt (you can leave it empty).</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Values.TotalValues">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Values.ViewLink">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Condition.ViewLink">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Condition.SaveBeforeEdit">
    <Value>You need to save the product attribute before you can edit conditional attributes.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Deleted">
    <Value>The attribute has been deleted successfully.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Updated">
    <Value>The attribute has been updated successfully.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Added">
    <Value>The new attribute has been added successfully.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.Attributes.Values.BackToAttribute">
    <Value></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Payments.PayPalDirect.Instructions">
    <Value><![CDATA[<p><b>If you''re using this gateway ensure that your primary store currency is supported by Paypal.</b><br /><br />To configure plugin follow these steps:<br />1. Log into your Developer PayPal account (click <a href="https://www.paypal.com/us/webapps/mpp/referral/paypal-business-account2?partner_id=9JJPJNNPQ7PZ8" target="_blank">here</a> to create your account).<br />2. Click on My Apps & Credentials from the Dashboard.<br />3. Create new REST API app.<br />4. Copy your Client ID and Secret key below.<br />5. To be able to use recurring payments you need to set the webhook ID. You can get it manually in your PayPal account (enter the URL {0} below REST API application credentials), or automatically by pressing "{1}" button (not visible when running the site locally).<br /></p>]]></Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.GeneralCommon.BlockTitle.AdminArea">
    <Value>Admin area</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.GeneralCommon.AdminArea.UseRichEditorInMessageTemplates">
    <Value>Use rich editor on message templates</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.GeneralCommon.AdminArea.UseRichEditorInMessageTemplates.Hint">
    <Value>Indicates whether to use rich editor on message templates and campaigns details pages.</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.ProductAttributes.AttributeCombinations.AlreadyExists">
    <Value>The same combination already exists</Value>
  </LocaleResource>
  <LocaleResource Name="ShoppingCart.EstimateShipping.ZipPostalCode.Required">
    <Value>Zip / postal code is required</Value>
  </LocaleResource>
  <LocaleResource Name="ShoppingCart.EstimateShipping.Country.Required">
    <Value>Country is required</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.CustomerUser.BlockTitle.ExternalAuthentication">
    <Value>External authentication</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.CustomerUser.AllowCustomersToRemoveAssociations">
    <Value>Allow customers to remove associations</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Configuration.Settings.CustomerUser.AllowCustomersToRemoveAssociations.Hint">
    <Value>Check to allow customers to remove external authentication associations.</Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.Widgets.GoogleAnalytics.Instructions">
    <Value><![CDATA[<p>Google Analytics is a free website stats tool from Google. It keeps track of statistics about the visitors and eCommerce conversion on your website.<br /><br />Follow the next steps to enable Google Analytics integration:<br /><ul><li><a href=\"http://www.google.com/analytics/\" target=\"_blank\">Create a Google Analytics account</a> and follow the wizard to add your website</li><li>Copy the Tracking ID into the ''ID'' box below</li><li>Click the ''Save'' button below and Google Analytics will be integrated into your store</li></ul><br />If you would like to switch between Google Analytics (used by default) and Universal Analytics, then please use the buttons below:</p>]]></Value>
  </LocaleResource>
  <LocaleResource Name="Plugins.DiscountRules.CustomerRoles.Fields.CustomerRole.Select">
    <Value>Select customer role</Value>
  </LocaleResource>
  <LocaleResource Name="Admin.Catalog.Products.Fields.ShipSeparately.Hint">
    <Value>Check if the product should be shipped separately from other products (in single box). But notice that if the order includes several items of this product, all of them will be shipped in single box.</Value>
  </LocaleResource>
</Language>
'

CREATE TABLE #LocaleStringResourceTmp
	(
		[ResourceName] [nvarchar](200) NOT NULL,
		[ResourceValue] [nvarchar](max) NOT NULL
	)

INSERT INTO #LocaleStringResourceTmp (ResourceName, ResourceValue)
SELECT	nref.value('@Name', 'nvarchar(200)'), nref.value('Value[1]', 'nvarchar(MAX)')
FROM	@resources.nodes('//Language/LocaleResource') AS R(nref)

--do it for each existing language
DECLARE @ExistingLanguageID int
DECLARE cur_existinglanguage CURSOR FOR
SELECT [ID]
FROM [Language]
OPEN cur_existinglanguage
FETCH NEXT FROM cur_existinglanguage INTO @ExistingLanguageID
WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @ResourceName nvarchar(200)
	DECLARE @ResourceValue nvarchar(MAX)
	DECLARE cur_localeresource CURSOR FOR
	SELECT ResourceName, ResourceValue
	FROM #LocaleStringResourceTmp
	OPEN cur_localeresource
	FETCH NEXT FROM cur_localeresource INTO @ResourceName, @ResourceValue
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (EXISTS (SELECT 1 FROM [LocaleStringResource] WHERE LanguageID=@ExistingLanguageID AND ResourceName=@ResourceName))
		BEGIN
			UPDATE [LocaleStringResource]
			SET [ResourceValue]=@ResourceValue
			WHERE LanguageID=@ExistingLanguageID AND ResourceName=@ResourceName
		END
		ELSE 
		BEGIN
			INSERT INTO [LocaleStringResource]
			(
				[LanguageId],
				[ResourceName],
				[ResourceValue]
			)
			VALUES
			(
				@ExistingLanguageID,
				@ResourceName,
				@ResourceValue
			)
		END
		
		IF (@ResourceValue is null or @ResourceValue = '')
		BEGIN
			DELETE [LocaleStringResource]
			WHERE LanguageID=@ExistingLanguageID AND ResourceName=@ResourceName
		END
		
		FETCH NEXT FROM cur_localeresource INTO @ResourceName, @ResourceValue
	END
	CLOSE cur_localeresource
	DEALLOCATE cur_localeresource


	--fetch next language identifier
	FETCH NEXT FROM cur_existinglanguage INTO @ExistingLanguageID
END
CLOSE cur_existinglanguage
DEALLOCATE cur_existinglanguage

DROP TABLE #LocaleStringResourceTmp
GO

--delete setting
DELETE FROM [Setting]
WHERE [Name] = N'externalauthenticationsettings.autoregisterenabled'
GO

--new setting
IF NOT EXISTS (SELECT 1 FROM [Setting] WHERE [name] = N'customersettings.storeipaddresses')
BEGIN
	INSERT [Setting] ([Name], [Value], [StoreId])
	VALUES (N'customersettings.storeipaddresses', N'True', 0)
END
GO

--drop column
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('[ScheduleTask]') and NAME='LeasedByMachineName')
BEGIN
	ALTER TABLE [ScheduleTask] DROP COLUMN [LeasedByMachineName]
END
GO

--drop column
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('[ScheduleTask]') and NAME='LeasedUntilUtc')
BEGIN
	ALTER TABLE [ScheduleTask] DROP COLUMN [LeasedUntilUtc]
END
GO

--delete setting
DELETE FROM [Setting]
WHERE [Name] = N'paypalstandardpaymentsettings.pdtvalidateordertotal'
GO

--delete setting
DELETE FROM [Setting]
WHERE [Name] = N'paypalstandardpaymentsettings.enableipn'
GO

--delete setting
DELETE FROM [Setting]
WHERE [Name] = N'paypalstandardpaymentsettings.ipnurl'
GO

--delete setting
DELETE FROM [Setting]
WHERE [Name] = N'paypalstandardpaymentsettings.returnfrompaypalwithoutpaymentredirectstoorderdetailspage'
GO

--delete setting
DELETE FROM [Setting]
WHERE [Name] = N'paypalstandardpaymentsettings.addressoverride'
GO

--new topic
IF NOT EXISTS (
  SELECT 1
  FROM [dbo].[Topic]
  WHERE [SystemName] = N'VendorTermsOfService')
BEGIN
	INSERT [dbo].[Topic] ([SystemName], [TopicTemplateId], [IncludeInSitemap], [AccessibleWhenStoreClosed], [LimitedToStores], [IncludeInFooterColumn1], [IncludeInFooterColumn2], [IncludeInFooterColumn3], [IncludeInTopMenu], [IsPasswordProtected], [DisplayOrder], [SubjectToAcl], [Published], [Title], [Body])
	VALUES (N'VendorTermsOfService', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, N'', N'<p>Put your terms of service information here. You can edit this in the admin site.</p>')

	DECLARE @TopicId INT 
	SET @TopicId = @@IDENTITY

	INSERT [dbo].[UrlRecord] ([EntityId], [EntityName], [Slug], [IsActive], [LanguageId])
	VALUES (@TopicId, N'Topic', N'vendortermsofservice', 1, 0)

END
GO

--new setting
IF NOT EXISTS (SELECT 1 FROM [Setting] WHERE [name] = N'commonsettings.popupfortermsofservicelinks')
BEGIN
	INSERT [Setting] ([Name], [Value], [StoreId])
	VALUES (N'commonsettings.popupfortermsofservicelinks', N'True', 0)
END
GO

--recreate index
IF EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_Log_CreatedOnUtc' and object_id=object_id(N'[dbo].[Log]'))
BEGIN
	DROP INDEX [IX_Log_CreatedOnUtc] ON [Log]
END
GO
	
CREATE NONCLUSTERED INDEX [IX_Log_CreatedOnUtc] ON [Log] ([CreatedOnUtc] DESC)
GO

--recreate index
IF EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_ActivityLog_CreatedOnUtc' and object_id=object_id(N'[dbo].[ActivityLog]'))
BEGIN
	DROP INDEX [IX_ActivityLog_CreatedOnUtc] ON [ActivityLog]
END
GO

CREATE NONCLUSTERED INDEX [IX_ActivityLog_CreatedOnUtc] ON [ActivityLog] ([CreatedOnUtc] DESC)
GO

--recreate index
IF EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_QueuedEmail_CreatedOnUtc' and object_id=object_id(N'[dbo].[QueuedEmail]'))
BEGIN
	DROP INDEX [IX_QueuedEmail_CreatedOnUtc] ON [QueuedEmail]
END
GO

CREATE NONCLUSTERED INDEX [IX_QueuedEmail_CreatedOnUtc] ON [QueuedEmail] ([CreatedOnUtc] DESC)
GO

--new index
IF NOT EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_Order_CreatedOnUtc' and object_id=object_id(N'[dbo].[Order]'))
BEGIN
	CREATE NONCLUSTERED INDEX [IX_Order_CreatedOnUtc] ON [Order] ([CreatedOnUtc] DESC)
END
GO

--new index
IF NOT EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_Customer_CreatedOnUtc' and object_id=object_id(N'[dbo].[Customer]'))
BEGIN
	CREATE NONCLUSTERED INDEX [IX_Customer_CreatedOnUtc] ON [Customer] ([CreatedOnUtc] DESC)
END
GO

--new activity types
IF NOT EXISTS (SELECT 1 FROM [ActivityLogType] WHERE [SystemKeyword] = N'DeleteSystemLog')
BEGIN
	INSERT [ActivityLogType] ([SystemKeyword], [Name], [Enabled])
	VALUES (N'DeleteSystemLog', N'Delete system log', N'true')
END
GO

--new setting
IF NOT EXISTS (SELECT 1 FROM [Setting] WHERE [name] = N'ordersettings.allowadminstobuycallforpriceproducts')
BEGIN
	INSERT [Setting] ([Name], [Value], [StoreId])
	VALUES (N'ordersettings.allowadminstobuycallforpriceproducts', N'True', 0)
END
GO

--new setting
IF NOT EXISTS (SELECT 1 FROM [Setting] WHERE [name] = N'canadapostsettings.selectedservicescodes')
BEGIN
	INSERT [Setting] ([Name], [Value], [StoreId])
	VALUES (N'canadapostsettings.selectedservicescodes', N'', 0)
END
GO

--new column
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('[CustomerRole]') and NAME='OverrideTaxDisplayType')
BEGIN
	ALTER TABLE [CustomerRole]
	ADD [OverrideTaxDisplayType] bit NULL
END
GO

UPDATE [CustomerRole]
SET [OverrideTaxDisplayType] = 0
WHERE [OverrideTaxDisplayType] IS NULL
GO

ALTER TABLE [CustomerRole] ALTER COLUMN [OverrideTaxDisplayType] bit NOT NULL
GO

--new column
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('[CustomerRole]') and NAME='DefaultTaxDisplayTypeId')
BEGIN
	ALTER TABLE [CustomerRole]
	ADD [DefaultTaxDisplayTypeId] int NULL
END
GO

UPDATE [CustomerRole]
SET [DefaultTaxDisplayTypeId] = 0
WHERE [DefaultTaxDisplayTypeId] IS NULL
GO

ALTER TABLE [CustomerRole] ALTER COLUMN [DefaultTaxDisplayTypeId] int NOT NULL
GO

--new column
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StorePickupPoint]') and OBJECTPROPERTY(object_id, N'IsUserTable') = 1)
AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[StorePickupPoint]') and NAME='DisplayOrder')
BEGIN
	ALTER TABLE [StorePickupPoint]
	ADD [DisplayOrder] INT NULL
END
GO

UPDATE [StorePickupPoint]
SET [DisplayOrder] = 0
WHERE [DisplayOrder] IS NULL
GO

ALTER TABLE [StorePickupPoint] ALTER COLUMN [DisplayOrder] INT NOT NULL
GO

--new index
IF NOT EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_Product_Picture_Mapping_ProductId' and object_id=object_id(N'[dbo].[Product_Picture_Mapping]'))
BEGIN
	CREATE NONCLUSTERED INDEX [IX_Product_Picture_Mapping_ProductId] ON [Product_Picture_Mapping] ([ProductId] ASC)
END
GO

--new index
IF NOT EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_PCM_ProductId' and object_id=object_id(N'[dbo].[Product_Category_Mapping]'))
BEGIN
	CREATE NONCLUSTERED INDEX [IX_PCM_ProductId] ON [Product_Category_Mapping] ([ProductId] ASC)
END
GO

--new index
IF NOT EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_PCM_ProductId_Extended' and object_id=object_id(N'[dbo].[Product_Category_Mapping]'))
BEGIN
	CREATE NONCLUSTERED INDEX [IX_PCM_ProductId_Extended] ON [Product_Category_Mapping] ([ProductId] ASC, [IsFeaturedProduct] ASC) INCLUDE ([CategoryId])
END
GO

--new index
IF NOT EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_PMM_ProductId' and object_id=object_id(N'[dbo].[Product_Manufacturer_Mapping]'))
BEGIN
	CREATE NONCLUSTERED INDEX [IX_PMM_ProductId] ON [Product_Manufacturer_Mapping] ([ProductId] ASC)
END
GO

--new index
IF NOT EXISTS (SELECT 1 from sys.indexes WHERE [NAME]=N'IX_PMM_ProductId_Extended' and object_id=object_id(N'[dbo].[Product_Manufacturer_Mapping]'))
BEGIN
	CREATE NONCLUSTERED INDEX [IX_PMM_ProductId_Extended] ON [Product_Manufacturer_Mapping] ([ProductId] ASC, [IsFeaturedProduct] ASC) INCLUDE ([ManufacturerId])
END
GO

--new setting
IF NOT EXISTS (SELECT 1 FROM [Setting] WHERE [name] = N'seosettings.querystringincanonicalurlsenabled')
BEGIN
	INSERT [Setting] ([Name], [Value], [StoreId])
	VALUES (N'seosettings.querystringincanonicalurlsenabled', N'False', 0)
END
GO

--new setting
IF NOT EXISTS (SELECT 1 FROM [Setting] WHERE [name] = N'externalauthenticationsettings.allowcustomerstoremoveassociations')
BEGIN
	INSERT [Setting] ([Name], [Value], [StoreId])
	VALUES (N'externalauthenticationsettings.allowcustomerstoremoveassociations', N'True', 0)
END
GO