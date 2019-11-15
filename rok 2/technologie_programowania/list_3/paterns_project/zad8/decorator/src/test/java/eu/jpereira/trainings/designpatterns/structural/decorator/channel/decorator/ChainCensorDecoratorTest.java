package eu.jpereira.trainings.designpatterns.structural.decorator.channel.decorator;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannel;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannelBuilder;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannelProperties;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannelPropertyKey;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.spy.TestSpySocialChannel;

public class ChainCensorDecoratorTest extends AbstractSocialChanneldDecoratorTest {

	@Test
	public void testChainThreeDecorators() {
		SocialChannelBuilder builder = createTestSpySocialChannelBuilder();

		SocialChannelProperties props = new SocialChannelProperties().putProperty(SocialChannelPropertyKey.NAME,
				TestSpySocialChannel.NAME);

		SocialChannel channel = builder.with(new MessageTruncator(10)).with(new URLAppender("http://W8jpereira.eu"))
				.with(new WordCensor("W8")).getDecoratedChannel(props);

		channel.deliverMessage("this is a message");
		TestSpySocialChannel spyChannel = (TestSpySocialChannel) builder.buildChannel(props);
		assertEquals("this is... http://###jpereira.eu", spyChannel.lastMessagePublished());
	}

	@Test
	public void testChainThreeDecoratorsWithoutBuilder() {

		SocialChannel channel = new TestSpySocialChannel();

		SocialChannel wordCensorChannel = new WordCensor("elektryczny", channel);

		SocialChannel urlAppenderChannel = new URLAppender("http://jpereira.elektryczny", wordCensorChannel);

		SocialChannel messageTruncatorChannel = new MessageTruncator(10, urlAppenderChannel);

		messageTruncatorChannel.deliverMessage("this is a message");
		TestSpySocialChannel spy = (TestSpySocialChannel) channel;
		assertEquals("this is... http://jpereira.###", spy.lastMessagePublished());
	}

	@Test
	public void testOtherChainThreeDecorators() {
		SocialChannelBuilder builder = createTestSpySocialChannelBuilder();

		SocialChannelProperties props = new SocialChannelProperties().putProperty(SocialChannelPropertyKey.NAME,
				TestSpySocialChannel.NAME);

		SocialChannel channel = builder.with(new URLAppender("http://jpereira.eu")).andWith(new MessageTruncator(30))
				.andWith(new WordCensor("W4")).getDecoratedChannel(props);

		channel.deliverMessage("this is a W4");
		TestSpySocialChannel spyChannel = (TestSpySocialChannel) builder.buildChannel(props);
		assertEquals("this is a ### http://jpereir...", spyChannel.lastMessagePublished());
	}
}
