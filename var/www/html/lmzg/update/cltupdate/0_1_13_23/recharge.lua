RechargeFunc.Execute = function( )
	local l_AppController = GameUI.SUIAppController:Instance( )
	if Me:GetIBTotal( ) > 0 then
		local szFinalURL = string.format( SIdToStyle( UIConfigs.RechargeURL ), LoginMgr:GetSvrId( ) )
		l_AppController:OpenRecharge( szFinalURL, Login.AccountRecord )
	else
		local szFinalURL = string.format(
			"http://passport.linekong.com/register/lmTip.html?gatewayId=%d&pName=",
			LoginMgr:GetSvrId( ) )

		szFinalURL = szFinalURL .. l_AppController:UrlEscape( Login.AccountRecord )

		IEWindow.Show( szFinalURL )
		IEWindow.SetWndSize( 664, 402 )
	end
end
