/*
 * Copyright 2004,2005 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.sith.cep.broker;

import org.apache.axis2.engine.AxisConfiguration;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.wso2.carbon.broker.core.BrokerConfiguration;
import org.wso2.carbon.broker.core.BrokerListener;
import org.wso2.carbon.broker.core.BrokerType;
import org.wso2.carbon.broker.core.BrokerTypeDto;
import org.wso2.carbon.broker.core.Property;
import org.wso2.carbon.broker.core.exception.BrokerEventProcessingException;

import java.util.Locale;
import java.util.ResourceBundle;

public final class SithBrokerType implements BrokerType {

    private static final Log log = LogFactory.getLog(SithBrokerType.class);

    private static final String BROKER_TYPE_SITH = "SithBroker";
    private static final String BROKER_CONF_SITH_PROPERTY_REFERENCE = "sithBrokerProperty";
    private static final String BROKER_CONF_SITH_PROPERTY_DISPLAY_NAME_REFERENCE = "sith.broker.property.display.name";


    private BrokerTypeDto brokerTypeDto = null;

    private static SithBrokerType testBrokerType = new SithBrokerType();

    private SithBrokerType() {
        this.brokerTypeDto = new BrokerTypeDto();
        this.brokerTypeDto.setName(BROKER_TYPE_SITH);

        ResourceBundle resourceBundle = ResourceBundle.getBundle(
                "org.sith.cep.broker.Resources", Locale.getDefault());

        // set default Subject as a property
        Property factoryInitialProperty = new Property(BROKER_CONF_SITH_PROPERTY_REFERENCE);
        factoryInitialProperty.setRequired(true);
        factoryInitialProperty.setDisplayName(resourceBundle.getString(
                BROKER_CONF_SITH_PROPERTY_DISPLAY_NAME_REFERENCE));
		getBrokerTypeDto().addProperty(factoryInitialProperty);
    }

    public static SithBrokerType getInstance() {
        return testBrokerType;
    }

    public String subscribe(String topicName,
                            BrokerListener brokerListener,
                            BrokerConfiguration brokerConfiguration,
                            AxisConfiguration axisConfiguration)
            throws BrokerEventProcessingException {
        throw new BrokerEventProcessingException("Can not subscribe to Sith broker " + brokerConfiguration.getName());
    }

    public void publish(String topicName,
                        Object message,
                        BrokerConfiguration brokerConfiguration)
            throws BrokerEventProcessingException {
        System.out.println("topicName:" + topicName + " message" + message);
    }

    @Override
    public void testConnection(BrokerConfiguration brokerConfiguration) throws BrokerEventProcessingException {
        //no test
    }

    public BrokerTypeDto getBrokerTypeDto() {
        return brokerTypeDto;
    }

    public void unsubscribe(String topicName,
                            BrokerConfiguration brokerConfiguration,
                            AxisConfiguration axisConfiguration, String subscriptionId)
            throws BrokerEventProcessingException {


    }

}
