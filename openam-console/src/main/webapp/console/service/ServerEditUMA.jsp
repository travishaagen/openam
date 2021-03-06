<%--
  ~ The contents of this file are subject to the terms of the Common Development and 
  ~ Distribution License (the License). You may not use this file except in compliance with the 
  ~ License.
  ~
  ~ You can obtain a copy of the License at legal/CDDLv1.0.txt. See the License for the 
  ~ specific language governing permission and limitations under the License.
  ~
  ~ When distributing Covered Software, include this CDDL Header Notice in each file and include 
  ~ the License file at legal/CDDLv1.0.txt. If applicable, add the following below the CDDL 
  ~ Header, with the fields enclosed by brackets [] replaced by your own identifying 
  ~ information: "Portions copyright [year] [name of copyright owner]".
  ~
  ~ Copyright 2015 ForgeRock AS.
  --%>

<%@ page info="ServerEditUMA" language="java" %>
<%@taglib uri="/WEB-INF/jato.tld" prefix="jato" %>
<%@taglib uri="/WEB-INF/cc.tld" prefix="cc" %>
<jato:useViewBean className="com.sun.identity.console.service.ServerEditUMAViewBean" fireChildDisplayEvents="true" >
    <cc:i18nbundle baseName="amConsole" id="amConsole" locale="<%=((com.sun.identity.console.base.AMViewBeanBase)viewBean).getUserLocale()%>"/>
    <cc:header name="hdrCommon" pageTitle="webconsole.title" bundleID="amConsole" copyrightYear="2007" fireDisplayEvents="true">
        <script language="javascript">
            // Field names.
            var fields = {
                resourcesets: {
                        storeLocationRadioButtonName: 'ServerEditUMA.cscorg-forgerock-services-resourcesets-store-location',
                        sslEnableCheckBoxName: 'ServerEditUMA.cscorg-forgerock-services-resourcesets-store-ssl-enabled',
                        directoryNameFieldName: 'ServerEditUMA.cscorg-forgerock-services-resourcesets-store-directory-name',
                        portFieldName: 'ServerEditUMA.cscorg-forgerock-services-resourcesets-store-port',
                        loginIdFieldName: 'ServerEditUMA.cscorg-forgerock-services-resourcesets-store-loginid',
                        passwordFieldName: 'ServerEditUMA.cscorg-forgerock-services-resourcesets-store-password',
                        maxConnectionsFieldName: 'ServerEditUMA.cscorg-forgerock-services-resourcesets-store-max-connections',
                        heartbeat: 'ServerEditUMA.cscorg-forgerock-services-resourcesets-store-heartbeat'
                },
                audit: {
                        storeLocationRadioButtonName: 'ServerEditUMA.cscorg-forgerock-services-umaaudit-store-location',
                        sslEnableCheckBoxName: 'ServerEditUMA.cscorg-forgerock-services-umaaudit-store-ssl-enabled',
                        directoryNameFieldName: 'ServerEditUMA.cscorg-forgerock-services-umaaudit-store-directory-name',
                        portFieldName: 'ServerEditUMA.cscorg-forgerock-services-umaaudit-store-port',
                        loginIdFieldName: 'ServerEditUMA.cscorg-forgerock-services-umaaudit-store-loginid',
                        passwordFieldName: 'ServerEditUMA.cscorg-forgerock-services-umaaudit-store-password',
                        maxConnectionsFieldName: 'ServerEditUMA.cscorg-forgerock-services-umaaudit-store-max-connections',
                        heartbeat: 'ServerEditUMA.cscorg-forgerock-services-umaaudit-store-heartbeat'
                },
                pendingrequests: {
                    storeLocationRadioButtonName: 'ServerEditUMA.cscorg-forgerock-services-uma-pendingrequests-store-location',
                    sslEnableCheckBoxName: 'ServerEditUMA.cscorg-forgerock-services-uma-pendingrequests-store-ssl-enabled',
                    directoryNameFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-pendingrequests-store-directory-name',
                    portFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-pendingrequests-store-port',
                    loginIdFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-pendingrequests-store-loginid',
                    passwordFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-pendingrequests-store-password',
                    maxConnectionsFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-pendingrequests-store-max-connections',
                    heartbeat: 'ServerEditUMA.cscorg-forgerock-services-uma-pendingrequests-store-heartbeat'
                },
                labels: {
                    storeLocationRadioButtonName: 'ServerEditUMA.cscorg-forgerock-services-uma-labels-store-location',
                    sslEnableCheckBoxName: 'ServerEditUMA.cscorg-forgerock-services-uma-labels-store-ssl-enabled',
                    directoryNameFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-labels-store-directory-name',
                    portFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-labels-store-port',
                    loginIdFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-labels-store-loginid',
                    passwordFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-labels-store-password',
                    maxConnectionsFieldName: 'ServerEditUMA.cscorg-forgerock-services-uma-labels-store-max-connections',
                    heartbeat: 'ServerEditUMA.cscorg-forgerock-services-uma-labels-store-heartbeat'
                }
            };

            window.onload = function() {
                setState(fields.audit);
                setState(fields.resourcesets);
                setState(fields.pendingrequests);
                setState(fields.labels);
            };

            function setState(fieldset) {
                // Set the initial state of the fields.
                var radioBtns = document.getElementsByName(fieldset.storeLocationRadioButtonName);

                if (radioBtns.length != 2) {
                    // Do nothing, there must be two radio buttons.
                    return;
                }

                toggleExternalConfig(fieldset, (radioBtns[0].checked) ? radioBtns[0] : radioBtns[1]);
            }

            // Retrieves the first element of the given name.
            function getFirstElementByName(name) {
                var elements = document.getElementsByName(name);
                return (elements.length > 0) ? elements[0] : null;
            }

            // Toggles the status of the external configuration fields.
            function toggleExternalConfig(fieldset, storeLocationRadioButton) {
                var readonly = storeLocationRadioButton.value === 'default';
                toggleField(fieldset.sslEnableCheckBoxName, readonly);
                toggleField(fieldset.directoryNameFieldName, readonly);
                toggleField(fieldset.portFieldName, readonly);
                toggleField(fieldset.loginIdFieldName, readonly);
                toggleField(fieldset.passwordFieldName, readonly);
                toggleField(fieldset.maxConnectionsFieldName, false);
                toggleField(fieldset.heartbeat, readonly);
            }

            // Toggles the status of a given field.
            function toggleField(fieldName, readonly) {
                var field = getFirstElementByName(fieldName);

                if (field != null) {
                    if (readonly) {
                        field.setAttribute('readonly', 'readonly');
                        field.className = 'TxtFldDis';
                    } else {
                        field.removeAttribute('readonly');
                        field.className = 'TxtFld';
                    }
                }
            }
        </script>

        <cc:form name="ServerEditUMA" method="post" defaultCommandChild="/button1">
            <script language="javascript">
                function confirmLogout() {
                    return confirm("<cc:text name="txtLogout" defaultValue="masthead.logoutMessage" bundleID="amConsole"/>");
                }
            </script>
            <cc:primarymasthead name="mhCommon" bundleID="amConsole"  logoutOnClick="return confirmLogout();" locale="<%=((com.sun.identity.console.base.AMViewBeanBase)viewBean).getUserLocale()%>"/>
            <cc:breadcrumbs name="breadCrumb" bundleID="amConsole" />
            <cc:tabs name="tabCommon" bundleID="amConsole" />

            <table border="0" cellpadding="10" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <cc:alertinline name="ialertCommon" bundleID="amConsole" />
                    </td>
                </tr>
            </table>

            <%-- PAGE CONTENT --------------------------------------------------------- --%>
            <cc:pagetitle name="pgtitleThreeBtns" bundleID="amConsole" pageTitleText="page.title.server.edit" showPageTitleSeparator="true" viewMenuLabel="" pageTitleHelpMessage="" showPageButtonsTop="true" showPageButtonsBottom="false" />

            <table border="0" cellpadding="10" cellspacing="0" width="100%">
                <tr><td>
                    <cc:button name="btnInherit" bundleID="amConsole" defaultValue="serverconfig.button.inherit" type="primary" />
                </td></tr>
            </table>

            <cc:propertysheet name="propertyAttributes" bundleID="amConsole" showJumpLinks="true"/>

        </cc:form>

    </cc:header>
</jato:useViewBean>
