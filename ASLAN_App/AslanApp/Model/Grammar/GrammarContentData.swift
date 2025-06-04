// AslanApp/Model/GrammarContentData.swiftAdd commentMore actions
import Foundation

struct GrammarContentData {

    static let allMaterials: [GrammarMaterial] = [
        // --- Materi untuk "Frasa Umum Sehari-hari" ---
        GrammarMaterial(
            courseTitle: "Common Daily Phrases",
            topicTitle: "Basic Greetings",
            explanation: """
            Greetings are essential for starting conversations. These are some of the most common ways to greet someone in Mandarin Chinese.
            你好 (Nǐ hǎo) is the most standard hello.
            早上好 (Zǎoshang hǎo) is for 'good morning'.
            """,
            examples: [
                ExampleSentence(chinese: "你好！", pinyin: "Nǐ hǎo!", english: "Hello!"),
                ExampleSentence(chinese: "你们好！", pinyin: "Nǐmen hǎo!", english: "Hello (to more than one person)!"),
                ExampleSentence(chinese: "早上好！", pinyin: "Zǎoshang hǎo!", english: "Good morning!"),
                ExampleSentence(chinese: "晚上好！", pinyin: "Wǎnshang hǎo!", english: "Good evening!")
            ],
            tip: "Use 你好 (Nǐ hǎo) in most situations. For a more respectful greeting to an elder or someone in authority, you can use 您好 (Nín hǎo)."
        ),
        GrammarMaterial(
            courseTitle: "Common Daily Phrases",
            topicTitle: "Expressing Gratitude and Apology",
            explanation: """
            Knowing how to say thank you and sorry is very important for polite interaction.
            谢谢 (Xièxie) is the common way to say 'thank you'.
            不客气 (Bú kèqi) means 'you're welcome'.
            对不起 (Duìbuqǐ) is 'sorry'.
            """,
            examples: [
                ExampleSentence(chinese: "谢谢！", pinyin: "Xièxie!", english: "Thank you!"),
                ExampleSentence(chinese: "非常感谢！", pinyin: "Fēicháng gǎnxiè!", english: "Thank you very much!"),
                ExampleSentence(chinese: "不客气。", pinyin: "Bú kèqi.", english: "You're welcome."),
                ExampleSentence(chinese: "对不起。", pinyin: "Duìbuqǐ.", english: "Sorry."),
                ExampleSentence(chinese: "没关系。", pinyin: "Méi guānxi.", english: "It's okay. / No problem.")
            ],
            tip: "When someone thanks you, replying with 不客气 (Bú kèqi) is standard. 没事 (Méi shì) is also common for 'no problem'."
        ),

        // --- Materi untuk "Tata Bahasa Dasar Mandarin" ---
        GrammarMaterial(
            courseTitle: "Basic Chinese Grammar",
            topicTitle: "Using 是 (shì) - To Be",
            explanation: """
            是 (shì) is a fundamental verb in Chinese, often equivalent to 'to be' (am, is, are, was, were).
            It's used to link a subject with a noun or pronoun that identifies or describes the subject.
            Structure: Subject + 是 (shì) + Noun.
            """,
            examples: [
                ExampleSentence(chinese: "我是学生。", pinyin: "Wǒ shì xuéshēng.", english: "I am a student."),
                ExampleSentence(chinese: "这是书。", pinyin: "Zhè shì shū.", english: "This is a book."),
                ExampleSentence(chinese: "他是一名老师。", pinyin: "Tā shì yī míng lǎoshī.", english: "He is a teacher."),
                ExampleSentence(chinese: "他们是朋友。", pinyin: "Tāmen shì péngyǒu.", english: "They are friends.")
            ],
            tip: "Remember, 是 (shì) primarily links two nouns or identifies something. For describing qualities with adjectives, you often use 很 (hěn) instead of 是 (shì), e.g., '她很高兴 (Tā hěn gāoxìng) - She is very happy'."
        ),
        GrammarMaterial(
            courseTitle: "Basic Chinese Grammar",
            topicTitle: "Using 的 (de) - Possessive/Descriptive Particle",
            explanation: """
            The particle 的 (de) is one of the most common particles in Chinese. It's used to indicate possession (like 's in English) or to link an adjective/description to a noun.
            Possession: Noun/Pronoun + 的 (de) + Noun
            Description: Adjective + 的 (de) + Noun
            """,
            examples: [
                ExampleSentence(chinese: "我的书。", pinyin: "Wǒ de shū.", english: "My book."),
                ExampleSentence(chinese: "他的名字。", pinyin: "Tā de míngzi.", english: "His name."),
                ExampleSentence(chinese: "红色的苹果。", pinyin: "Hóngsè de píngguǒ.", english: "Red apple."),
                ExampleSentence(chinese: "漂亮的女孩。", pinyin: "Piàoliang de nǚhái.", english: "Beautiful girl.")
            ],
            tip: "When the relationship is very close or obvious (like with family members or body parts), 的 (de) can sometimes be omitted, e.g., 我妈妈 (Wǒ māma) for 'my mom'."
        ),
        GrammarMaterial(
            courseTitle: "Basic Chinese Grammar",
            topicTitle: "Negating with 不 (bù)",
            explanation: """
            不 (bù) is used to negate verbs in the present or future, and also to negate adjectives. It generally means 'not' or 'no'.
            Structure for verbs: Subject + 不 (bù) + Verb
            Structure for adjectives: Subject + 不 (bù) + Adjective
            Note: The tone of 不 (bù) changes to bú when it precedes a fourth tone syllable.
            """,
            examples: [
                ExampleSentence(chinese: "我不吃肉。", pinyin: "Wǒ bù chī ròu.", english: "I don't eat meat."),
                ExampleSentence(chinese: "他不是学生。", pinyin: "Tā bú shì xuéshēng.", english: "He is not a student."), // Note: Bú before shì (4th tone)
                ExampleSentence(chinese: "这个不贵。", pinyin: "Zhège bù guì.", english: "This is not expensive."),
                ExampleSentence(chinese: "我们不去。", pinyin: "Wǒmen bú qù.", english: "We are not going.") // Note: Bú before qù (4th tone)
            ],
            tip: "For negating past actions or the completion of an action, use 没 (méi) or 没有 (méiyǒu) instead of 不 (bù)."
        ),

        // --- Materi untuk "Struktur Kalimat Dasar" ---
        GrammarMaterial(
            courseTitle: "Basic Sentence Patterns",
            topicTitle: "Basic Order: Subject-Verb-Object (SVO)",
            explanation: """
            The most common sentence structure in Mandarin Chinese is Subject-Verb-Object (SVO), which is similar to English.
            The subject performs the action, the verb is the action, and the object receives the action.
            """,
            examples: [
                ExampleSentence(chinese: "我爱你。", pinyin: "Wǒ (S) ài (V) nǐ (O).", english: "I love you."),
                ExampleSentence(chinese: "他看书。", pinyin: "Tā (S) kàn (V) shū (O).", english: "He reads a book."),
                ExampleSentence(chinese: "小猫喝水。", pinyin: "Xiǎo māo (S) hē (V) shuǐ (O).", english: "The kitten drinks water.")
            ],
            tip: "While SVO is standard, time phrases and adverbs often come after the subject but before the verb."
        ),
        GrammarMaterial(
            courseTitle: "Basic Sentence Patterns",
            topicTitle: "Asking Yes/No Questions with 吗 (ma)",
            explanation: """
            To turn a declarative statement into a yes/no question in Chinese, you can simply add the particle 吗 (ma) to the end of the sentence.
            The word order of the statement does not change.
            """,
            examples: [
                ExampleSentence(chinese: "你是学生吗？", pinyin: "Nǐ shì xuéshēng ma?", english: "Are you a student?"),
                ExampleSentence(chinese: "他喜欢猫吗？", pinyin: "Tā xǐhuān māo ma?", english: "Does he like cats?"),
                ExampleSentence(chinese: "这个贵吗？", pinyin: "Zhège guì ma?", english: "Is this expensive?"),
                ExampleSentence(chinese: "你们去吗？", pinyin: "Nǐmen qù ma?", english: "Are you (plural) going?")
            ],
            tip: "吗 (ma) is used for questions where a 'yes' or 'no' answer is expected. For 'wh-' questions (who, what, where), you'll use different question words like 谁 (shéi), 什么 (shénme), 哪里 (nǎlǐ)."
        ),
        
        // --- Materi untuk "Kata Kerja Umum" ---
        GrammarMaterial(
            courseTitle: "Common Verbs",
            topicTitle: "Action Verbs: 去 (qù), 来 (lái), 吃 (chī), 喝 (hē)",
            explanation: """
            These are some very common action verbs.
            去 (qù) means 'to go'.
            来 (lái) means 'to come'.
            吃 (chī) means 'to eat'.
            喝 (hē) means 'to drink'.
            Chinese verbs do not conjugate for tense or person in the same way English verbs do.
            """,
            examples: [
                ExampleSentence(chinese: "我去学校。", pinyin: "Wǒ qù xuéxiào.", english: "I go to school."),
                ExampleSentence(chinese: "他明天来。", pinyin: "Tā míngtiān lái.", english: "He will come tomorrow."),
                ExampleSentence(chinese: "我们吃米饭。", pinyin: "Wǒmen chī mǐfàn.", english: "We eat rice."),
                ExampleSentence(chinese: "你想喝什么？", pinyin: "Nǐ xiǎng hē shénme?", english: "What do you want to drink?")
            ],
            tip: "Context, time words (like 今天 - jīntiān, 昨天 - zuótiān), and particles like 了 (le) help indicate tense or aspect."
        ),
        GrammarMaterial(
            courseTitle: "Common Verbs",
            topicTitle: "Verbs of Being & Having: 在 (zài), 有 (yǒu)",
            explanation: """
            在 (zài) can mean 'to be at (a place)' or indicate an ongoing action.
            有 (yǒu) means 'to have' or 'there is/are'.
            """,
            examples: [
                ExampleSentence(chinese: "我在家。", pinyin: "Wǒ zài jiā.", english: "I am at home."),
                ExampleSentence(chinese: "他在看书。", pinyin: "Tā zài kàn shū.", english: "He is reading a book (action in progress)."),
                ExampleSentence(chinese: "我有一个苹果。", pinyin: "Wǒ yǒu yī ge píngguǒ.", english: "I have an apple."),
                ExampleSentence(chinese: "这里有人吗？", pinyin: "Zhèli yǒu rén ma?", english: "Is there anyone here?")
            ],
            tip: "To negate 有 (yǒu), use 没有 (méiyǒu). For example, 我没有钱 (Wǒ méiyǒu qián) - I don't have money."
        )
    ]

    // Helper function to get materials for a specific course title
    static func materials(forCourseTitle title: String) -> [GrammarMaterial] {
        return allMaterials.filter { $0.courseTitle == title }
    }
}
