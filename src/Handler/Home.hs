{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Lucius
import Text.Julius

getPage2R :: Handler Html
getPage2R = do 
    defaultLayout $ do 
        $(whamletFile "templates/page2.hamlet")

getPage1R :: Handler Html
getPage1R = do
    defaultLayout $ do 
        addStylesheet (StaticR css_bootstrap_css)
        $(whamletFile "templates/page1.hamlet")
        toWidgetHead $(luciusFile "templates/page1.lucius")
        toWidgetHead $(juliusFile "templates/page1.julius")

getHomeR :: Handler Html
getHomeR = do 
    defaultLayout $ do 
        sess <- lookupSession "_NOME"
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead [julius|
            function ola(){
                alert("ola");
            }
        |]
        toWidgetHead [lucius|
            h1 {
                color : red;
            }
            li{
                display: inline;
                list-style: none;
            }
        |]
        [whamlet|
            <h1>
                OLA MUNDO!
            
            <ul>
                <li>
                    <a href=@{Page1R}>
                        Pagina 1
                <li>
                    <a href=@{Page2R}>
                        Pagina 2
                $maybe nomeSess <- sess
                    <li>
                        <form method=post action=@{LogoutR}>
                            <input type="submit" value="Sair">
                    <div>
                        Ola #{nomeSess}
                $nothing
                    <img src=@{StaticR pikachu_jpg}>
            
            <button class="btn btn-danger" onclick="ola()">
                OLA
        |]
