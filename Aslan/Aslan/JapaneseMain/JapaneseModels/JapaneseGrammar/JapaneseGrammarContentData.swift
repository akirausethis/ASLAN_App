// AslanApp/Model/GrammarContentData.swift
import Foundation

struct GrammarContentData {

    static let allMaterials: [GrammarMaterial] = [
        // --- Materi untuk "Basic Particles" (Sudah ada) ---
        GrammarMaterial(
            courseTitle: "Basic Particles",
            topicTitle: "Particle は (wa) - Topic Marker",
            explanation: "Particle は (wa) is a topic marker...",
            examples: [/*...*/], tip: "..."
        ),
        GrammarMaterial(
            courseTitle: "Basic Particles",
            topicTitle: "Particle が (ga) - Subject Marker",
            explanation: "Particle が (ga) is a subject marker...",
            examples: [/*...*/], tip: "..."
        ),
        GrammarMaterial(
            courseTitle: "Basic Particles",
            topicTitle: "Particle を (o) - Object Marker",
            explanation: "Particle を (o) is an object marker...",
            examples: [/*...*/], tip: "..."
        ),

        // --- Materi untuk "Verb Conjugation" (Sudah ada) ---
        GrammarMaterial(
            courseTitle: "Verb Conjugation",
            topicTitle: "Present Tense (ます -masu form)",
            explanation: "The -masu form (ます) is a polite way...",
            examples: [/*...*/], tip: "..."
        ),
        GrammarMaterial(
            courseTitle: "Verb Conjugation",
            topicTitle: "Present Negative (ません -masen form)",
            explanation: "The -masen form (ません) is the polite negative...",
            examples: [/*...*/], tip: "..."
        ),

        // --- Materi untuk "Sentence Structure" (Sudah ada) ---
        GrammarMaterial(
            courseTitle: "Sentence Structure",
            topicTitle: "Basic Order: Subject-Object-Verb (SOV)",
            explanation: "The most basic Japanese sentence structure is Subject-Object-Verb (SOV)...",
            examples: [/*...*/], tip: "..."
        ),
        GrammarMaterial(
            courseTitle: "Sentence Structure",
            topicTitle: "Adding か (ka) for Questions",
            explanation: "To turn a declarative sentence into a question...",
            examples: [/*...*/], tip: "..."
        ),

        // --- MATERI BARU UNTUK INTERMEDIATE ---

        // Materi untuk "Te-Form"
        GrammarMaterial(
            courseTitle: "Te-Form",
            topicTitle: "Forming the Te-Form (て形)",
            explanation: "The Te-form is a crucial verb conjugation in Japanese used for various grammatical functions, such as connecting clauses, making requests, indicating ongoing actions, and more. Formation rules vary depending on the verb group (Godan, Ichidan, Irregular).",
            examples: [
                ExampleSentence(japanese: "たべて (食べる - Ichidan)", romaji: "tabete (taberu)", english: "eat / eating (and...)"),
                ExampleSentence(japanese: "のんで (飲む - Godan 'mu')", romaji: "nonde (nomu)", english: "drink / drinking (and...)"),
                ExampleSentence(japanese: "いって (行く - Godan 'ku' special)", romaji: "itte (iku)", english: "go / going (and...)"),
                ExampleSentence(japanese: "して (する - Irregular)", romaji: "shite (suru)", english: "do / doing (and...)"),
                ExampleSentence(japanese: "きて (来る - Irregular)", romaji: "kite (kuru)", english: "come / coming (and...)")
            ],
            tip: "Mastering Te-form conjugation is key to unlocking more complex sentence structures."
        ),
        GrammarMaterial(
            courseTitle: "Te-Form",
            topicTitle: "Using Te-Form for Joining Clauses",
            explanation: "One of the main uses of the Te-form is to connect multiple actions or states in a sequence. It can often be translated as '...and then...'.",
            examples: [
                ExampleSentence(japanese: "あさごはんをたべて、がっこうへいきました。", romaji: "Asagohan o tabete, gakkou e ikimashita.", english: "I ate breakfast and then went to school."),
                ExampleSentence(japanese: "シャワーをあびて、ねます。", romaji: "Shawaa o abite, nemasu.", english: "I will take a shower and then sleep.")
            ],
            tip: "The actions are generally presented in chronological order when using Te-form this way."
        ),
        GrammarMaterial(
            courseTitle: "Te-Form",
            topicTitle: "Requests with ～てください (Te kudasai)",
            explanation: "By adding ください (kudasai) to the Te-form of a verb, you can make a polite request.",
            examples: [
                ExampleSentence(japanese: "ちょっとまってください。", romaji: "Chotto matte kudasai.", english: "Please wait a moment."),
                ExampleSentence(japanese: "これをみてください。", romaji: "Kore o mite kudasai.", english: "Please look at this.")
            ],
            tip: "This is a very common and useful way to ask someone to do something politely."
        ),

        // Materi untuk "Potential Form"
        GrammarMaterial(
            courseTitle: "Potential Form",
            topicTitle: "Expressing 'Can Do' (～ことができる)",
            explanation: "A straightforward way to express ability is by using the dictionary form of a verb + ことができる (koto ga dekiru). This literally means 'the act of (verb) is possible'.",
            examples: [
                ExampleSentence(japanese: "わたしはにほんごをはなすことができます。", romaji: "Watashi wa nihongo o hanasu koto ga dekimasu.", english: "I can speak Japanese."),
                ExampleSentence(japanese: "かれはおよぐことができます。", romaji: "Kare wa oyogu koto ga dekimasu.", english: "He can swim.")
            ],
            tip: "This form is a bit more formal or emphatic than the conjugated potential verb form."
        ),
        GrammarMaterial(
            courseTitle: "Potential Form",
            topicTitle: "Conjugated Potential Verbs (～える/～られる)",
            explanation: "Verbs can be conjugated into a potential form to express ability. For Ichidan verbs, replace final る (ru) with られる (rareru). For Godan verbs, change the final 'u' vowel to 'e' and add る (ru).",
            examples: [
                ExampleSentence(japanese: "たべられる (食べる - Ichidan)", romaji: "taberareru (taberu)", english: "can eat"),
                ExampleSentence(japanese: "はなせる (話す - Godan)", romaji: "hanaseru (hanasu)", english: "can speak"),
                ExampleSentence(japanese: "こられる (来る - Irregular)", romaji: "korareru (kuru)", english: "can come")
            ],
            tip: "The conjugated potential form is very common in everyday speech."
        ),
        GrammarMaterial(
            courseTitle: "Potential Form",
            topicTitle: "Using Potential Form in Sentences",
            explanation: "When using the conjugated potential form, the object that one 'can do' is often marked with が (ga) instead of を (o), though を (o) is also sometimes used.",
            examples: [
                ExampleSentence(japanese: "にほんごがはなせます。", romaji: "Nihongo ga hanasemasu.", english: "I can speak Japanese."),
                ExampleSentence(japanese: "ピアノがひけますか。", romaji: "Piano ga hikemasu ka.", english: "Can you play the piano?")
            ],
            tip: "Pay attention to the particle (often が) used with potential verbs."
        ),
        
        // Materi untuk "Giving & Receiving"
        GrammarMaterial(
            courseTitle: "Giving & Receiving",
            topicTitle: "あげる (ageru) - Giving (outward)",
            explanation: "あげる (ageru) is used when the speaker (or someone in the speaker's in-group) gives something to an outsider, or when an outsider gives something to another outsider.",
            examples: [
                ExampleSentence(japanese: "わたしはともだちにはなをあげました。", romaji: "Watashi wa tomodachi ni hana o agemashita.", english: "I gave flowers to my friend."),
                ExampleSentence(japanese: "たなかさんはやまださんにおみやげをあげました。", romaji: "Tanaka-san wa Yamada-san ni omiyage o agemashita.", english: "Mr. Tanaka gave a souvenir to Mr. Yamada.")
            ],
            tip: "The direction of giving is away from the speaker or speaker's perspective."
        ),
        GrammarMaterial(
            courseTitle: "Giving & Receiving",
            topicTitle: "くれる (kureru) - Giving (inward)",
            explanation: "くれる (kureru) is used when someone (an outsider or another member of the speaker's in-group) gives something to the speaker or a member of the speaker's in-group.",
            examples: [
                ExampleSentence(japanese: "ともだちがわたしにプレゼントをくれました。", romaji: "Tomodachi ga watashi ni purezento o kuremashita.", english: "My friend gave me a present."),
                ExampleSentence(japanese: "せんせいがわたしのあににほんをくれました。", romaji: "Sensei ga watashi no ani ni hon o kuremashita.", english: "The teacher gave my older brother a book.")
            ],
            tip: "The direction of giving is towards the speaker or speaker's in-group."
        ),
        GrammarMaterial(
            courseTitle: "Giving & Receiving",
            topicTitle: "もらう (morau) - Receiving",
            explanation: "もらう (morau) is used from the perspective of the receiver. It means 'to receive' or 'to get something from someone'.",
            examples: [
                ExampleSentence(japanese: "わたしはともだちにプレゼントをもらいました。", romaji: "Watashi wa tomodachi ni purezento o moraimashita.", english: "I received a present from my friend."),
                ExampleSentence(japanese: "かれはせんせいからしょうをもらいました。", romaji: "Kare wa sensei kara shou o moraimashita.", english: "He received an award from the teacher. (kara can also be used instead of ni for the giver with morau)")
            ],
            tip: "もらう focuses on the act of receiving by the subject of the sentence."
        ),

        // --- MATERI BARU UNTUK EXPERT ---

        // Materi untuk "Passive Voice"
        GrammarMaterial(
            courseTitle: "Passive Voice",
            topicTitle: "Forming Passive Verbs (～(ら)れる)",
            explanation: "The passive voice is used to indicate that an action is done to the subject. For Ichidan verbs, add られる (rareru) to the stem. For Godan verbs, change the final 'u' vowel to 'a' and add れる (reru). する becomes される, 来る becomes こられる.",
            examples: [
                ExampleSentence(japanese: "たべられる (食べる - Ichidan)", romaji: "taberareru (taberu)", english: "to be eaten"),
                ExampleSentence(japanese: "いわれる (言う - Godan)", romaji: "iwareru (iu)", english: "to be said/told"),
                ExampleSentence(japanese: "される (する - Irregular)", romaji: "sareru (suru)", english: "to be done")
            ],
            tip: "Note that the passive form of Ichidan verbs is identical to their potential form. Context determines meaning."
        ),
        GrammarMaterial(
            courseTitle: "Passive Voice",
            topicTitle: "Direct Passive Sentences",
            explanation: "In a direct passive sentence, the subject is directly affected by the action. The agent (doer of the action) is often marked by に (ni).",
            examples: [
                ExampleSentence(japanese: "わたしはせんせいにほめられました。", romaji: "Watashi wa sensei ni homeraremashita.", english: "I was praised by the teacher."),
                ExampleSentence(japanese: "このえはピカソによってかかれました。", romaji: "Kono e wa Pikaso ni yotte kakaremashita.", english: "This picture was painted by Picasso. (によって is often used for famous works/discoveries)")
            ],
            tip: "The focus is on the person or thing undergoing the action."
        ),
        GrammarMaterial(
            courseTitle: "Passive Voice",
            topicTitle: "Indirect/Adversative Passive",
            explanation: "Japanese also has an 'indirect' or 'adversative' passive, where the subject is negatively affected by an action, even if not directly involved. This often expresses inconvenience or trouble.",
            examples: [
                ExampleSentence(japanese: "わたしはあめにふられました。", romaji: "Watashi wa ame ni furaremashita.", english: "I was rained on (adversely affected by rain)."),
                ExampleSentence(japanese: "かれはさいふをぬすまれました。", romaji: "Kare wa saifu o nusumaremashita.", english: "He had his wallet stolen (adversely affected by someone stealing his wallet).")
            ],
            tip: "This type of passive is unique to Japanese and often conveys a sense of misfortune."
        ),

        // Materi untuk "Causative Form"
        GrammarMaterial(
            courseTitle: "Causative Form",
            topicTitle: "Forming Causative Verbs (～(さ)せる)",
            explanation: "The causative form is used to express 'making' or 'letting' someone do something. For Ichidan verbs, add させる (saseru) to the stem. For Godan verbs, change final 'u' to 'a' and add せる (seru). する becomes させる, 来る becomes こさせる.",
            examples: [
                ExampleSentence(japanese: "たべさせる (食べる - Ichidan)", romaji: "tabesaseru (taberu)", english: "to make/let eat"),
                ExampleSentence(japanese: "いかせる (行く - Godan)", romaji: "ikaseru (iku)", english: "to make/let go"),
                ExampleSentence(japanese: "させる (する - Irregular)", romaji: "saseru (suru)", english: "to make/let do")
            ],
            tip: "Causative verbs indicate that the subject causes another person (the causee) to perform an action."
        ),
        GrammarMaterial(
            courseTitle: "Causative Form",
            topicTitle: "Using Causative: Making Someone Do",
            explanation: "When making someone do something, the 'causee' (person being made to do) is usually marked with に (ni) if the verb is intransitive, or を (o) if the verb is transitive (and the original object is also present).",
            examples: [
                ExampleSentence(japanese: "せんせいはがくせいにほんをよませました。", romaji: "Sensei wa gakusei ni hon o yomasemashita.", english: "The teacher made the student read a book."),
                ExampleSentence(japanese: "はははこどもにやさいをたべさせました。", romaji: "Haha wa kodomo ni yasai o tabesasemashita.", english: "The mother made the child eat vegetables.")
            ],
            tip: "The particle marking the causee can be tricky; に is common for 'making' someone do an action they might not want to."
        ),
        GrammarMaterial(
            courseTitle: "Causative Form",
            topicTitle: "Using Causative: Letting Someone Do",
            explanation: "When 'letting' or 'allowing' someone do something, the causee is often marked with に (ni), and the action is often something the causee wants to do. The verb ～てあげる can be added for nuance (～(さ)せてあげる).",
            examples: [
                ExampleSentence(japanese: "わたしはむすこにゲームをさせてあげました。", romaji: "Watashi wa musuko ni geemu o sasete agemashita.", english: "I let my son play a game."),
                ExampleSentence(japanese: "かれはかのじょにいかせました。", romaji: "Kare wa kanojo ni ikasemashita.", english: "He let her go.")
            ],
            tip: "The nuance between 'make' and 'let' often depends on context and additional phrasing."
        ),

        // Materi untuk "Conditional Forms"
        GrammarMaterial(
            courseTitle: "Conditional Forms",
            topicTitle: "～たら (tara) - If/When (General)",
            explanation: "The ～たら (tara) conditional is formed by adding ら (ra) to the past tense (Ta-form) of verbs and adjectives. It's versatile and can be used for general conditions, specific future events, or things that happened in the past ('when X happened, Y happened').",
            examples: [
                ExampleSentence(japanese: "やすかったら、かいます。", romaji: "Yasukattara, kaimasu.", english: "If it's cheap, I'll buy it."),
                ExampleSentence(japanese: "じかんがあったら、えいがをみにいきましょう。", romaji: "Jikan ga attara, eiga o mi ni ikimashou.", english: "If you have time, let's go see a movie."),
                ExampleSentence(japanese: "いえへかえったら、てがみをかきました。", romaji: "Ie e kaettara, tegami o kakimashita.", english: "When I returned home, I wrote a letter.")
            ],
            tip: "たら is often the go-to conditional for many situations due to its broad applicability."
        ),
        GrammarMaterial(
            courseTitle: "Conditional Forms",
            topicTitle: "～ば (ba) - If (Hypothetical/Formal)",
            explanation: "The ～ば (ba) conditional is formed by changing the final 'u' of verbs to 'eba' (e.g., 行く -> 行けば ikeba). For i-adjectives, change い to ければ (e.g., 安い -> 安ければ yasukereba). It often implies a more hypothetical or logical consequence and can sound slightly more formal or written.",
            examples: [
                ExampleSentence(japanese: "かねがあれば、りょこうにいけます。", romaji: "Kane ga areba, ryokou ni ikemasu.", english: "If I had money, I could go on a trip."),
                ExampleSentence(japanese: "はやくいけば、まにあいます。", romaji: "Hayaku ikeba, maniaimasu.", english: "If you go early, you'll make it in time.")
            ],
            tip: "The clause following ～ば often expresses a desirable outcome or a natural consequence."
        ),
        GrammarMaterial(
            courseTitle: "Conditional Forms",
            topicTitle: "～と (to) - If/When (Natural Consequence)",
            explanation: "The ～と (to) conditional is formed by adding と to the dictionary form of verbs or adjectives. It's used when one action or state naturally or inevitably leads to another, or for habitual actions ('whenever X, Y happens').",
            examples: [
                ExampleSentence(japanese: "はるになると、さくらがさきます。", romaji: "Haru ni naru to, sakura ga sakimasu.", english: "When spring comes, cherry blossoms bloom."),
                ExampleSentence(japanese: "このボタンをおすと、ドアがあきます。", romaji: "Kono botan o osu to, doa ga akimasu.", english: "If you press this button, the door will open.")
            ],
            tip: "と is not usually used for expressing intentions, commands, or requests in the second clause."
        ),
        GrammarMaterial(
            courseTitle: "Conditional Forms",
            topicTitle: "～なら (nara) - If (Contextual/Speaker's Assumption)",
            explanation: "The ～なら (nara) conditional is often used when the condition is based on something previously mentioned or assumed by the speaker. It's formed by adding なら to nouns, dictionary form of verbs, or adjectives. It often carries a nuance of 'if that's the case...' or 'speaking of X...'.",
            examples: [
                ExampleSentence(japanese: "にほんへいくなら、きょうとがいいですよ。", romaji: "Nihon e iku nara, Kyouto ga ii desu yo.", english: "If you're going to Japan, Kyoto is good."),
                ExampleSentence(japanese: "あなたがそう言うなら、しんじます。", romaji: "Anata ga sou iu nara, shinjimasu.", english: "If you say so, I'll believe you.")
            ],
            tip: "なら often introduces advice, suggestions, or a focused response based on the given condition."
        )
    ]

    // Helper function untuk mendapatkan materi berdasarkan judul kursus
    static func materials(forCourseTitle title: String) -> [GrammarMaterial] {
        return allMaterials.filter { $0.courseTitle == title }
    }
}
