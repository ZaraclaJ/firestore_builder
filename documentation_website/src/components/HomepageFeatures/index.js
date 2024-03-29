import Heading from '@theme/Heading';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Easy to Use',
    Svg: require('@site/static/img/easy.svg').default,
    description: (
      <>
        Firestore Builder simplifies the creation and management of your Firestore database.
        With just a few lines of configuration in a YAML file, Firestore Builder automates
        the generation of model classes and service layers, eliminating the need for manual coding.
      </>
    ),
  },
  {
    title: 'Focus on What Matters',
    Svg: require('@site/static/img/focus.svg').default,
    description: (
      <>
        With Firestore Builder, you can focus on designing your Firestore database
        and organizing your data without worrying about the tedious management
         of model code and services.
      </>
    ),
  },
  {
    title: 'Time-saving',
    Svg: require('@site/static/img/time.svg').default,
    description: (
      <>
        Firestore Builder drastically reduces development time by simplifying 
        the integration of Firestore into your Flutter application. This streamlined 
        process accelerates your development workflow, allowing you to focus more on 
        building features and less on boilerplate setup.
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
