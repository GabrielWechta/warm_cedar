package eu.jpereira.trainings.designpatterns.structural.decorator.channel.decorator;

import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannel;

public class WordCensor extends SocialChannelDecorator {
	String forbiddenWord;

	public WordCensor(String forbiddenWord) {
		this.forbiddenWord = forbiddenWord;
	}
	
	public WordCensor(String forbiddenWord, SocialChannel decoratedChannel) {
		this.forbiddenWord = forbiddenWord;
		this.delegate = decoratedChannel;
	}
	
	@Override
	public void deliverMessage(String message) {
		message = message.replaceAll(forbiddenWord, "###");
		delegate.deliverMessage(message);
	}

}
