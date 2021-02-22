import React from 'react';
import {default as CSound} from '@kunstmusik/csound';
import generative1 from './projects/generative1.csd';

class CSoundComponent extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            loadedProject: null,
            csoundInitialized: false,
            csound: null,
            playing: false
        };
    }

    componentDidMount() {
        document.addEventListener('beforeunload', this.handleCsoundUnload);
        console.log('did mount');

        CSound.initialize().then(() => {
            console.log('promise fulfilled');
            const csound = new CSound();

            this.setState({
                csoundInitialized: true,
                csound: csound
            });
        });
    }

    componentWillUnmount() {
        this.handleCsoundUnload();
        document.removeEventListener('beforeunload', this.handleCsoundUnload);
        console.log('unmount');
    }

    handleCsoundUnload() {
        this.state.csound.stop();
        this.state.csound.reset();
        this.state.csound.destroy();
    }

    handleProjectClick(projectId) {
        return () => {
            console.log('i am pressed', projectId);
            // console.log(generative1);

            this.setState({
                loadedProject: projectId
            });

            this.state.csound.compileCSD(generative1);
        };
    }

    handleToggleClick() {
        return () => {
            console.log('toggle play clicked');

            this.setState({
                playing: true
            });

            this.state.csound.setOption('-+msg_color=false');
            this.state.csound.audioContext.resume();
            this.state.csound.start();
        };
    }


    render() {
        return (
            <div>
                {'CSoundComponent'}
                <h3>Csound Projects</h3>
                <h3>Project 1</h3>
                <p>This is an endless generative piece of creepy music!</p>
                {this.state.csoundInitialized 
                    ? (
                        <div>
                            CSOUND INITIALIZED, you can load project now
                            <br />
                            <a href="#" onClick={this.handleProjectClick('project 1')}>LOAD 1</a><br />
                            {/*<a href="#" onClick={this.handleProjectClick('project 2')}>LOAD 2</a><br />*/}
                            {/*<a href="#" onClick={this.handleProjectClick('project 3')}>LOAD 3</a><br />*/}
                        </div>
                    )
                    : <div>Csound Initializing do not touch shit</div>
                }
                <a href="#" onClick={this.handleToggleClick('project 3')}>Play</a><br />
                <div>{JSON.stringify(this.state)}</div>
            </div>
        );
    }

}

export default CSoundComponent;


