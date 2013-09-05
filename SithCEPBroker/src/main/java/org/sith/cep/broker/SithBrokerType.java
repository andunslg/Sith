package org.sith.cep.broker;

import org.apache.axis2.engine.AxisConfiguration;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONException;
import org.json.JSONObject;
import org.sith.cep.broker.util.HTTPUtil;
import org.wso2.carbon.broker.core.BrokerConfiguration;
import org.wso2.carbon.broker.core.BrokerListener;
import org.wso2.carbon.broker.core.BrokerType;
import org.wso2.carbon.broker.core.BrokerTypeDto;
import org.wso2.carbon.broker.core.exception.BrokerEventProcessingException;

import java.util.*;

public final class SithBrokerType implements BrokerType {

	private static final Log log = LogFactory.getLog(SithBrokerType.class);

	private static final String BROKER_TYPE_SITH = "SithBroker";

	private BrokerTypeDto brokerTypeDto = null;

	private static SithBrokerType sithBrokerType= new SithBrokerType();

	private HTTPUtil httpUtil=new HTTPUtil();


	private SithBrokerType() {
		this.brokerTypeDto = new BrokerTypeDto();
		this.brokerTypeDto.setName(BROKER_TYPE_SITH);

	}

	public static SithBrokerType getInstance() {
		return sithBrokerType;
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

		if(message instanceof Map){
			String nodeMethodUri=topicName;

			Map<String, Object> messageMap=(Map<String, Object>)message;
			Map<String,String> parmMap= new HashMap<String,String>();

			for(String key:messageMap.keySet()){
				if(messageMap.get(key) instanceof String){
					parmMap.put(key,(String)messageMap.get(key)) ;
				}
				else{
					parmMap.put(key,messageMap.get(key).toString()) ;
				}
			}

			sendToNode(nodeMethodUri,parmMap);
		}
		else if(message instanceof String){

			String jsonMessage="{"+message+"}";
			try{
				JSONObject jsonObject=new JSONObject(jsonMessage);
				String nodeMethodUri=topicName;
				Iterator keySet=jsonObject.keys();

				Map<String,String> parmMap= new HashMap<String,String>();

				while(keySet.hasNext()){
					String key=(String)keySet.next();
					parmMap.put(key,(String)jsonObject.get(key));
				}

				sendToNode(nodeMethodUri,parmMap);
			}catch(JSONException e){
				log.info("Message is not in the correct format"+e.getMessage());
			}


		}
		else{
			log.info("Message is not in the correct format");
		}

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

	public boolean sendToNode(String methodURI,Map<String,String> parms){
		String result=null;

		try{
			result=httpUtil.doPost(methodURI,parms);
			if(!result.equals("")){
				if("{\"response\":true}".equals(result)){
					return true;
				}
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}


}